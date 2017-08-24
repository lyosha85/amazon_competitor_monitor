require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'validation' do
    let(:group) { FactoryGirl.build(:group) }

    describe 'name' do
      it 'should be present' do
        group.name = ''
        expect(group.valid?).to be false
      end
    end
    describe 'account' do
      it 'should be present' do
        group.account = nil
        expect(group.valid?).to be false
      end
    end
  end
end
