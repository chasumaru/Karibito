if Rails.env == "development"

  User.create!(
    name: "chasu",
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password",
    confirmed_at: DateTime.now,
    admin: true)


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