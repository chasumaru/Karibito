FactoryBot.define do
  factory :notification do
    visitor_id { Faker::Number.number(digits: 3) }
    visited_id { Faker::Number.number(digits: 3) }
    post_id { Faker::Number.number(digits: 3) }
    comment_id { Faker::Number.number(digits: 3) }
    action { "" }
    checked { false }
  end
end
