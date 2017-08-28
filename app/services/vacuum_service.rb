class VacuumService
  include Service

  def initialize(asin, request_type)
    @asin = asin
    @request_type = request_type
  end

  def call
    case @request_type
    when :inventory_count_lookup
      inventory_count_lookup
    when :item_lookup
      item_lookup
    else
      raise ArgumentError.new('request_type must be :inventory_count_lookup or :item_lookup')
    end
  end

  private

  def inventory_count_lookup
    request = vacuum_request
    hmac = SecureRandom.base64

    retries = 0
    begin
      cart = request.cart_create(
        query: {
          'HMAC' => hmac,
          'Item.1.ASIN' => @asin,
          'Item.1.Quantity' => 999
        }
      )
    rescue ServiceUnavailable
      retries += 1
      sleep 1
      retry if retries <= 3
      return nil
    end

    cart = cart.to_h

    # The item turned out to be out of stock, see readme.
    return 0 if cart['CartCreateResponse']['Cart']['Request']['Errors']['Error']['Code'] == 'AWS.ECommerceService.ItemNotEligibleForCart'
    cart['CartCreateResponse']['Cart']['CartItems']['CartItem']['Quantity'].to_i
  end

  def item_lookup
    retries = 0
    begin
      @result ||= vacuum_request.item_lookup(
        query: {
          ItemId: @asin,
          ResponseGroup: 'ItemAttributes,Images,SalesRank,Reviews'
        }
      ).to_h
    rescue Excon::Error::ServiceUnavailable
      retries =+ 1
      sleep 1
      retry if retries <= 3
      raise 'Could not connect.'
    end

    request = @result['ItemLookupResponse']['Items']['Request']

    if request['IsValid'] == 'True' || request['Errors'].nil?
      return @result
    else
      raise 'Vacuum request error.'
    end
  end

  def vacuum_request
    req = Vacuum.new('US')
    req.configure(
      aws_access_key_id: Rails.application.secrets[:amazon_key] || ENV['AZ_KEY'],
      aws_secret_access_key: Rails.application.secrets[:amazon_secret] || ENV['AZ_SECRET'],
      associate_tag: Rails.application.secrets[:amazon_tag] || ENV['AZ_TAG'],
    )
  end
end
