FactoryBot.define do
  factory :post do
    title                 { Faker::Lorem.characters(number: 10) }
    content               { Faker::Lorem.characters(number: 50) }
    user
  end
end