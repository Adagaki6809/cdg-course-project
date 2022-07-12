FactoryBot.define do
  factory :post do
    association :user
    #image { }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.png')) }
  end
end
