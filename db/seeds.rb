# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

account =  Account.first || Account.create(name: 'Alex')
group = Group.create(name: 'Baseball', account: account)

%w(B00ZLJ1QGC B01K8B5BYU B01JP6E9HY B011BX2C50 B002BZIVSU B00L9A95T2).each do |asin|
  Product.create(group: group, asin: asin)
end

# group2 = Group.create(name: 'Misc', account: account)
# %w(B015WAI2AC B0193R01EU B01AWZGBJG B01LWEMJVA B01N1JX1O4
#    B005BYZ2PI B0012ETPUE B01MS08YQB B0073YPHHW B06ZZWP9PN).each do |asin|
#   Product.create(group: group2, asin: asin)
# end
