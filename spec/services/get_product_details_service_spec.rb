require 'rails_helper'

RSpec.describe GetProductDetailsService do
  let(:asin) {'B01KO4Z9TS'}
  subject { service = GetProductDetailsService.new(asin) }

  it 'returns product price', :vcr do
    expect(subject.send(:price_cents)).to be_present
  end

  it 'returns product title', :vcr do
    expect(subject.send(:title)).to be_present
  end

  it 'returns product best seller rank number', :vcr do
    expect(subject.send(:bsr)).to be_present
  end

  it 'returns product inventory count', :vcr do
    expect(subject.send(:inventory)).to be_present
  end
end
