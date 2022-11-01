# README


環境:
- Docker
- Ruby:         3.1.2
- Rails:        7.0.2
- Nginx:        1.21.1
- MySQL:        8.0
- Tailwindcss   3.0.2


実装gems

*Hotwire
- turbo-rails
- stimulus-rails

*AssetsPipleline
- sprockets-rails
- importmap-rails
- cssbundling-rails

*各種機能
- devise
- minimagick
- acts-as-taggable-on
- pagy
- ransack
- dotenv-rails

*Test
- Rspec-rails
- factorybot-rails
- gimei
- bullet
- faker
- capybara
- shoulda-matchers


*管理者権限
- rubocop
- cancancan
- rails_admin ...sprocket-railsに依存している。propshaftは開発環境では動いた。しかし、本番環境へのデプロイ時にエラーが発生したため、sprocket-railsに切り替えた。

