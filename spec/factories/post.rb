FactoryBot.define do
  factory :post do
    title                 {'title'}
    content               {'content'}
    user
  end
end