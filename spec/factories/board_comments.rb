FactoryBot.define do
  factory :board_comment do
    description { "MyText" }
    user { nil }
    board { nil }
  end
end
