require 'rails_helper'

RSpec.describe GetProductDetailsService do
  let(:asin) {'B01KO4Z9TS'}
  subject { GetProductDetailsService.new(asin) }

  %w(asin title images features reviews_count
     bsr price_cents inventory).each do |attribute|

    it "returns product #{attribute}", :vcr do
      expect(subject.send(:price_cents)).to be_present
    end
  end

end
