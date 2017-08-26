require 'rails_helper'

RSpec.describe VacuumService do
  let(:asin) {'B01KO4Z9TS'}
  subject { VacuumService }

  context 'inventory_count_lookup' do
    let(:response) { subject.call(asin, :inventory_count_lookup) }
    it 'contains inventory data', :vcr do
      expect(response).to be_present
    end
  end

  context 'item_lookup' do
    let(:response) { subject.call(asin, :item_lookup) }
    it 'contains item data', :vcr do
      expect(response['ItemLookupResponse']).to be_present
    end
  end
end
