class GetProductDetailsService

  def initialize(asin)
    @asin = asin
  end

  def process
    get_product_details
  end

  private

  def get_product_details
    {
      asin:           @asin,
      title:          title,
      images:         images,
      features:       features,
      description:    description,
      reviews_count:  reviews_count,
      bsr:            bsr,
      bsr_category:   bsr_category,
      price_cents:    price_cents,
      inventory:      inventory
    }
  end

  def title
    az_item['ItemAttributes']['Title']
  end

  def images
    az_item['ItemAttributes']['ImageSets']
  end

  def features
    az_item['ItemAttributes']['Feature']
  end

  def description
    az_item['ItemAttributes']
  end

  def reviews_count
    reviews_page = Nokogiri::HTML(open(customer_reviews_url))
    reviews = reviews_page.css('.crAvgStars a').last.to_i
  end

  def bsr
    az_item['SalesRank']
  end

  def bsr_category
    category = az_item['SalesRank'].gsub(/\d\s?/, "")
    category.strip if category
  end

  def price_cents
    az_item['ItemAttributes']['ListPrice']['Amount']
  end

  def inventory
    request = vacuum_request
    hmac = SecureRandom.base64

    cart = request.cart_create(
      query: {
        'HMAC' => hmac,
        'Item.1.ASIN' => @asin,
        'Item.1.Quantity' => 999
      }
    )

    cart.to_h["CartCreateResponse"]["Cart"]["CartItems"]["CartItem"]["Quantity"]
  end

  def az_item
    @az_item = if vaccum_response.to_h['ItemLookupResponse']['Items']['Request']['IsValid'] == 'True'
      vaccum_response.to_h['ItemLookupResponse']['Items']['Item']
    end
  end

  def vaccum_response
    @vaccum_response ||= vacuum_request.item_lookup(
      query: {
        ItemId: @asin,
        ResponseGroup: 'ItemAttributes,Images,Reviews,OfferSummary,SalesRank'
      }
    )
  end

  def vacuum_request
    @req ||= Vacuum.new('US')
    @req.configure(
      aws_access_key_id: Rails.application.secrets[:amazon_key] || ENV['AZ_KEY'],
      aws_secret_access_key: Rails.application.secrets[:amazon_secret] || ENV['AZ_SECRET'],
      associate_tag: Rails.application.secrets[:amazon_tag] || ENV['AZ_TAG'],
    )
  end
end
