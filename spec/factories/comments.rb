FactoryBot.define do
  factory :comment do
    context  { Faker::Lorem.characters(number: 10) }
    association :user
    association :post
    reply_comment_id { 1 }
  end
end
