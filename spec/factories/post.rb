FactoryBot.define do
  factory :post do
    title                 { Faker::Lorem.characters(number: 10) }
    content               { Faker::Lorem.characters(number: 50) }
    association :user
  end
end