require 'rails_helper'

RSpec.describe GetProductDetailsService do
  let(:asin) {'B01KO4Z9TS'}
  subject { service = GetProductDetailsService.new(asin) }

  it 'returns product price', :vcr do
    expect(subject.send(:price_cents)).to eq '599'
  end

  it 'returns product title', :vcr do
    expect(subject.send(:title)).to eq 'Mostsola 20 Pcs LED Photo Clip String Lights Perfect for Pictures Notes Artwork LED Decor (Warm White)'
  end

  it 'returns product best seller rank number', :vcr do
    expect(subject.send(:bsr)).to be_a_kind_of(Integer)
  end
end
