FactoryBot.define do
  factory :user do
    gimei = Gimei.name
    name                  {gimei}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    profile               {Faker::Lorem.characters(number: 200)}
  end
end