FactoryBot.define do
  factory :coupon do
    code { Faker::Commerce.unique.promotion_code(digits:6) }
    status { [:active, :inactive].sample }
    discount_value { rand(1..90) }
    due_date { "2021-12-23 15:29:47" }
  end
end
