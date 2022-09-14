FactoryBot.define do
  factory :board_comment do
    description { "MyText" }
    user { nil }
    board { nil }
    reply_comment_id { 1 }
  end
end
