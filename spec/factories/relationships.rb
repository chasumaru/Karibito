FactoryBot.define do
  factory :relationship do
    follower_id { Faker::Number.number(digits: 3) }
    followed_id { Faker::Number.number(digits: 3) }
  end
end
