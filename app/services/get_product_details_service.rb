require 'open-uri'

class GetProductDetailsService
  include Service

  def initialize(asin)
    @asin = asin
  end

  def call
    get_product_details
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
    return nil unless item_details['ImageSets']['ImageSet']
    item_details['ImageSets']['ImageSet'].collect{|image_set| image_set['LargeImage']['URL']}
  end

  def features
    item_details['ItemAttributes']['Feature']
  end

  def reviews_count
    retries = 0
    begin
      reviews_page = Nokogiri::HTML(open(customer_reviews_url))
      reviews = reviews_page.css('.crAvgStars a').text.to_i
    rescue OpenURI::HTTPError
      retries += 1
      retry if retries <= 3
      nil
    end
  end

  def customer_reviews_url
    item_details['CustomerReviews']['IFrameURL']
  end

  def bsr
    # No BSR provided for items with parent asins
    if @asin == item_details['ParentASIN']
      item_details['SalesRank']
    elsif item_details['ParentASIN']
      # item_look makes a second call to get parent asin information
      item_lookup = VacuumService.call(item_details['ParentASIN'],:item_lookup)
      item_lookup['ItemLookupResponse']['Items']['Item']['SalesRank']
    else
      nil
    end
  end

  def price_cents
    item_details['ItemAttributes']['ListPrice'] ?
                    item_details['ItemAttributes']['ListPrice']['Amount'] : 0

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
