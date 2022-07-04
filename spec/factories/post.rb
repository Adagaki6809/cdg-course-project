FactoryBot.define do
  factory :post do
    association :user
    image {}
  end
end
