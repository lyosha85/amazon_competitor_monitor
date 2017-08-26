# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

account =  FactoryGirl.create(:account, name: 'Alex')
group = FactoryGirl.create(:group, name: 'My Competitors', account: account)

%w(B00ZLJ1QGC B01K8B5BYU B01JP6E9HY B011BX2C50 B002BZIVSU B00L9A95T2).each do |asin|
  FactoryGirl.create(:product, group: group, asin: asin)
end
