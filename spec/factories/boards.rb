FactoryBot.define do
  factory :board do
    title                 { Faker::Lorem.characters(number: 10) }
    description           { Faker::Lorem.characters(number: 50) }
    association :user
  end
end
