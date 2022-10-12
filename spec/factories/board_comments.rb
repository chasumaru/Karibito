FactoryBot.define do
  factory :board_comment do
    description { Faker::Lorem.characters(number: 10) }
    association :user
    association :board
  end
end