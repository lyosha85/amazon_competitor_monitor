require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation' do
    let(:group) { FactoryGirl.create(:group)}
    let(:product) { FactoryGirl.create(:product, group: group) }

    describe 'group' do
      it 'should be present' do
        product.group = nil
        expect(product.valid?).to be false
      end
    end
    describe 'asin' do
      it 'should be present' do
        product.asin = ''
        expect(product.valid?).to be false
      end
    end

    describe 'limit products per group' do
      it 'max 8' do
        9.times { Product.create(asin: "B00ZLJ1QG", group: group) }
        expect(group.products.count).to eq(8)
      end
    end
  end
end
