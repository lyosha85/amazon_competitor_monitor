require 'rails_helper'

RSpec.describe Snapshot, type: :model do
  context 'validations' do
    describe 'asin' do
      let(:snapshot) { FactoryGirl.build(:snapshot) }
      it 'should be present' do
        snapshot.asin = nil
        expect(snapshot.valid?).to be false
      end
    end
  end
  context '.previous_snapshot' do
    before {
      FactoryGirl.create(:snapshot, asin: '0000000000', price_cents: 1)
      FactoryGirl.create(:snapshot, asin: '1111111111', price_cents: 2)
      FactoryGirl.create(:snapshot, asin: '0000000000', price_cents: 3)
    }
    it 'returns previous snapshot' do
      snapshot = Snapshot.find_by(price_cents: 3)
      expect(snapshot.previous_snapshot.price_cents).to be(1)
    end
  end
end
