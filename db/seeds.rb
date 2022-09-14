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
  10.times do |s|
      User.create!(
        name: "#{Gimei.name}",
        email: "test#{s}@example.com",
        password: "password",
        password_confirmation: "password",
        confirmed_at: DateTime.now)
  end

  (1..10).each do |t|
    (1..30).each do |i|
      Post.create!(
        title: "投稿サンプル(#{t}の#{i})",
        content: "This is an sample post. This is useful for developer to check and modify layout (#ユーザー#{t}の#{i}番目の投稿)",
        created_at: DateTime.now,
        user_id: "#{t}")
      Board.create!(
        title: "投稿サンプル(#{t}の#{i})",
        description: "This is an sample Board. This is useful for developer to check and modify layout (#ユーザー#{t}の#{i}番目の投稿)",
        created_at: DateTime.now,
        user_id: "#{t}")
    end
  end 
end