Rails.application.routes.draw do

  root 'pages#index'
  get "pages/show"
  
  devise_for :users,
      module: "users",
      path: '',
      path_names: {
      sign_up: 'signup', sign_in: 'login', sign_out: 'logout',
      password: 'secret', confirmation: 'verification',
      registration: 'register', edit: 'edit/profile'
    }

    resources :users, only: [:show, :edit, :update]

    # 退会確認画面
    get '/softdeletes/:id/unsubscribe' => 'softdeletes#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/softdeletes/:id/withdrawal' => 'softdeletes#withdrawal', as: 'withdrawal'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
