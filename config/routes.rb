Rails.application.routes.draw do

  root 'static_pages#index'
  resources :posts

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
  end
end
