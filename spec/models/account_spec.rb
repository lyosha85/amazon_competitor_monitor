require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'validation' do
    describe 'name' do
      let(:account) { FactoryGirl.create(:account) }
      it 'should be present' do
        account.name = ''
        expect(account.valid?).to be false
      end
    end
  end
end
