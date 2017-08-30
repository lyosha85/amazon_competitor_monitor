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
        9.times { Product.create(asin: "B00ZLJ1QGC", group: group) }
        expect(group.products.count).to eq(8)
      end
    end
  end

  context 'scopes' do
    describe '#in_need_of_snapshots' do
      before do
        FactoryGirl.create(:product, last_checked: Time.zone.now)
        FactoryGirl.create(:product, last_checked: Time.zone.now - 1.day)
      end

      it 'shows records without a snapshot today' do
        expect(Product.require_new_snapshots.count).to be 1
      end
    end
  end

  context '.was_checked_today?' do
    let(:product_checked_yesterday) { FactoryGirl.create(:product,
                                                last_checked: 1.day.ago )}
    let(:product_checked_today) { FactoryGirl.create(:product,
                                                last_checked: Time.zone.now )}

    it 'returns false if checked yesterday' do
      expect(product_checked_yesterday.was_checked_today?).to be false
    end

    it 'returns true if checked today' do
      expect(product_checked_today.was_checked_today?).to be true
    end

  end
end
