FactoryBot.define do
  factory :comment do
    context { "MyText" }
    user { nil }
    post { nil }
    reply_comment_id { 1 }
  end
end
