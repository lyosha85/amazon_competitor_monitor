require 'rails_helper'

RSpec.describe Changes, type: :model do
  context '#group_in_date' do
    let(:group)   { FactoryGirl.create(:group, name: 'Hoge Toys') }

    let(:toy_car) { FactoryGirl.create(:product, group: group,
                                                 asin: '1111111111',
                                                 created_at: 10.days.ago)}

    let(:big_jar) { FactoryGirl.create(:product, group: group,
                                                 asin: '2222222222',
                                                 created_at: 10.days.ago)}

    before do
      FactoryGirl.create(:snapshot, asin: toy_car.asin, price_cents: 2,
                                    created_at: Time.zone.now - 1.day )

      FactoryGirl.create(:snapshot, asin: toy_car.asin, price_cents: 3,
                                    created_at: Time.zone.now )

      FactoryGirl.create(:snapshot, asin: big_jar.asin, price_cents: 5,
                                    title:'old', created_at: Time.zone.now - 5.day)

      FactoryGirl.create(:snapshot, asin: big_jar.asin, price_cents: 7,
                                    title:'new', created_at: Time.zone.now )
    end

    it 'returns a hash of changes' do
      changes = Changes.in_date(group, Time.zone.now.to_date)
      expect(changes.first['new']['price_cents']).to be 3
      expect(changes.first['old']['price_cents']).to be 2
      expect(changes.last['new']['title']).to eq 'new'
      expect(changes.last['old']['title']).to eq 'old'
    end
  end
end
