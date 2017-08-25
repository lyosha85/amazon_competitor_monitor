require 'rails_helper'

RSpec.describe GetProductDetailsService do
  let(:asin) {'B01KO4Z9TS'}

  it 'returns product price' do
    VCR.use_cassette(GetProductDetailsService , record: :new_episodes) do
      service = GetProductDetailsService.new(asin)
      expect(service.send(:price_cents)).to eq '599'
    end
  end

  it 'returns product title' do
    VCR.use_cassette(GetProductDetailsService , record: :new_episodes) do
      service = GetProductDetailsService.new(asin)
      expect(service.send(:title)).to eq 'Mostsola 20 Pcs LED Photo Clip String Lights Perfect for Pictures Notes Artwork LED Decor (Warm White)'
    end
  end

  it 'returns product best seller rank number' do
    VCR.use_cassette(GetProductDetailsService , record: :new_episodes) do
      service = GetProductDetailsService.new(asin)
      expect(service.send(:bsr)).to eq 43693
    end
  end
end
