# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# user = User.new(:name => 'name', :email => 'hoge@hoge.com', :password => 'hogehoge')
# user.save!
# user.confirm

if Rails.env == "development"
  (1..10).each do |s|
    User.create!(name: "ユーザー#{s}", email: "test#{s}@example.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  end
  (1..10).each do |t|
    (1..10).each do |i|
      Post.create!(title: "#{t}さんの#{i}", content: "This is an sample post. This is useful for developer to check and modify layout", created_at: DateTime.now, user_id: "#{t}")
    end
  end 
end