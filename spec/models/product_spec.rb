require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation' do
    let(:product) { FactoryGirl.build(:product) }

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
  end
end
