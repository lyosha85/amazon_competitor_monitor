FactoryGirl.define do
  factory :snapshot do
    title "MyString"
    images "MyText"
    features "MyText"
    description "MyText"
    reviews_count 1
    bsr 1
    bsr_category "MyString"
    asin "MyString"
    price_cents 1
  end
end
