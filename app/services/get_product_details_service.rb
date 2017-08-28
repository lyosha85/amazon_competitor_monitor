require 'open-uri'

class GetProductDetailsService
  include Service

  def initialize(asin)
    @asin = asin
  end

  def call
    error_503_message = "Error: 503 Service Unavailable while getting inventory for #{@asin}"
    begin
      get_product_details
    rescue Excon::Error::ServiceUnavailable
      Rails.logger.warn error_503_message
      {error: '503 Excon::Error::ServiceUnavailable'}
    rescue OpenURI::HTTPError
      Rails.logger.warn error_503_message
      {error: '503 OpenURI::HTTPError'}
    end
  end

  private

  def get_product_details
    {
      asin:           @asin,
      title:          title,
      images:         images,
      features:       features,
      reviews_count:  reviews_count,
      bsr:            bsr,
      price_cents:    price_cents,
      inventory:      inventory,
    }
  end

  def title
    item_details['ItemAttributes']['Title']
  end

  def images
    item_details['ItemAttributes']['ImageSets']
  end

  def features
    item_details['ItemAttributes']['Feature']
  end

  def reviews_count
    reviews_page = Nokogiri::HTML(open(customer_reviews_url))
    reviews = reviews_page.css('.crAvgStars a').text.to_i
  end

  def customer_reviews_url
    item_details['CustomerReviews']['IFrameURL']
  end

  def bsr
    # No BSR provided for items with parent asins
    if @asin == item_details['ParentASIN']
      item_details['SalesRank']
    else
      item_lookup = VacuumService.call(item_details['ParentASIN'], :item_lookup)
      item_lookup['ItemLookupResponse']['Items']['Item']['SalesRank']
    end
  end

  def price_cents
    item_details['ItemAttributes']['ListPrice']['Amount']
  end

  def inventory
    VacuumService.call(@asin, :inventory_count_lookup)
  end

  def item_details
    @item_details ||= item_lookup['ItemLookupResponse']['Items']['Item']
  end

  def item_lookup
    VacuumService.call(@asin, :item_lookup)
  end
end
