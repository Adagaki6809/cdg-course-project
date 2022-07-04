FactoryBot.define do
  factory :comment do
    association :user
    association :post
    content { FFaker::Lorem.paragraph }
  end
end
