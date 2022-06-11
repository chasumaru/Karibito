Rails.application.routes.draw do

  resources :posts

  root 'pages#index'
  # get "/profile" => 'pages#show', as: 'profile'
  get "/about" => 'pages#about', as: 'about'
  get "/contact" => 'pages#contact', as: 'contact'
  get "/privacy" => 'pages#privacy', as: 'privacy'
  get "/faq" => 'pages#faq', as: 'faq'
  get "/term" => 'pages#term', as: 'term'
  
  devise_for :users,
      module: "users",
      path: '',
      path_names: {
      sign_up: 'signup', sign_in: 'login', sign_out: 'logout',
      password: 'secret', confirmation: 'verification',
      registration: 'register', edit: 'edit/profile'
    }
  devise_scope :user do
    get "/:id/mypage", to: "users/accounts#show", as: 'mypage'
    get '/:id/unsubscribe' => 'users/accounts#unsubscribe', as: 'unsubscribe'
    patch '/:id/withdrawal' => 'users/accounts#withdrawal', as: 'withdrawal'
  end

  # 退会確認画面
  # get '/:id/unsubscribe' => 'softdeletes#unsubscribe', as: 'unsubscribe'
  # # 論理削除用のルーティング
  # patch '/:id/withdrawal' => 'softdeletes#withdrawal', as: 'withdrawal'
  
end
