Rails.application.routes.draw do

  resources :posts

  root 'static_pages#index'
  # get "/profile" => 'static_pages#show', as: 'profile'
  get "/about" => 'static_pages#about', as: 'about'
  get "/contact" => 'static_pages#contact', as: 'contact'
  get "/privacy" => 'static_pages#privacy', as: 'privacy'
  get "/faq" => 'static_pages#faq', as: 'faq'
  get "/term" => 'static_pages#term', as: 'term'
  get "/manual" => 'static_pages#manual', as: 'manual'
  
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
