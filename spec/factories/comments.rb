FactoryBot.define do
  factory :comment do
    context  { Faker::Lorem.characters(number: 10) }
    user
    post
    reply_comment_id { 1 }
  end
end
