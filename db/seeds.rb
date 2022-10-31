if Rails.env == "development"

  User.create!(
    name: "admin",
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
  Board.create!(
    title: "掲示板のご紹介",
    description: 
    "　常日頃、Karibitoをご利用いただきまして、誠にありがとうございます。さて、掲示板を通じて訪問者は誰でもスレッドを立てられます。そして、スレッド内で自由に掲示板コメントを投稿できます。狩猟が身近な方、身近ではなくても狩猟に興味がある方など、様々な人が自由に交流していただけることを期待します。
    ※ログインがまだお済みでないユーザーは、スレッド及びコメントの編集と削除を行うことが出来ませんのでご了承ください。
    　一方、管理者がモラルに反するスレッドやコメントと判断した場合は、事前の通知無く削除する場合がございます。ご理解いただけますよう宜しくお願い致します。",
    created_at: DateTime.now)
end


if Rails.env == "production"
  Board.create!(
    title: "掲示板のご紹介",
    description: 
    "　常日頃、Karibitoをご利用いただきまして、誠にありがとうございます。さて、掲示板を通じて訪問者は誰でもスレッドを立てられます。そして、スレッド内で自由に掲示板コメントを投稿できます。狩猟が身近な方、身近ではなくても狩猟に興味がある方など、様々な人が自由に交流していただけることを期待します。
    ※ログインがまだお済みでないユーザーは、スレッド及びコメントの編集と削除を行うことが出来ませんのでご了承ください。
    　一方、管理者がモラルに反するスレッドやコメントと判断した場合は、事前の通知無く削除する場合がございます。ご理解いただけますよう宜しくお願い致します。",
    created_at: DateTime.now)
end