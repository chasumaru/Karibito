Rails.application.routes.draw do

  root 'static_pages#index'

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  
  devise_for :users,
      module: "users",
      path: '',
      path_names: {
      sign_up: 'signup', sign_in: 'login', sign_out: 'logout',
      password: 'secret', confirmation: 'verification',
      registration: 'register', edit: 'edit/profile'
    }

  get "/about", to: 'static_pages#about', as: 'about'
  get "/contact", to: 'static_pages#contact', as: 'contact'
  get "/privacy", to: 'static_pages#privacy', as: 'privacy'
  get "/faq", to: 'static_pages#faq', as: 'faq'
  get "/term", to: 'static_pages#term', as: 'term'
  get "/manual", to: 'static_pages#manual', as: 'manual'
  
  
    get "/:id/profile", to: "users/accounts#show", as: 'profile'
    get '/:id/unsubscribe', to: 'users/accounts#unsubscribe', as: 'unsubscribe'
    get '/:id/following', to: 'users/accounts#following', as: 'following'
    get '/:id/followers', to: 'users/accounts#followers', as: 'followers'
end
