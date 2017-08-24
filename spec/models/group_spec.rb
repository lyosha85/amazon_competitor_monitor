require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'validation' do
    let(:account) { FactoryGirl.create(:account) }
    let(:group)   { FactoryGirl.create(:group, account: account) }

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
    describe 'groups per account' do
      it 'max 10' do
         11.times { Group.create(account: account, name: "Group") }
          expect(account.groups.count).to eq(10)
      end
    end
  end
end
