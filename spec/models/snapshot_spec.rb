require 'rails_helper'

RSpec.describe Snapshot, type: :model do
  context 'validations' do
    describe 'product' do
      let(:snapshot) { FactoryGirl.build(:snapshot) }
      it 'should be present' do
        snapshot.asin = nil
        expect(snapshot.valid?).to be false
      end
    end
  end
end
