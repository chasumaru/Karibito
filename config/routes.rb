Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'static_pages#index'

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resource :likes, only: [:create, :destroy]
    get :liked, on: :member
    get :tags, on: :collection
  end
  resources :relationships, only: [:create, :destroy]

  resources :boards do
    resources :board_comments, only: [:create, :edit, :update, :destroy]
    get :tags, on: :collection
  end

  resources :notifications, only: :index
  scope :notifications do
    delete '/destroy_all', to: 'notifications#destroy_all', as: 'destroy_all_notifications'
  end

  
  devise_for :users,
  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" },
  module: 'users',
    path: '',
    path_names: {
      sign_up: 'signup', sign_in: 'login', sign_out: 'logout',
      password: 'secret', confirmation: 'verification',
      registration: 'register', edit: 'edit/profile',
    }
    
    scope module: :users do
      get '/:id/profile', to: 'accounts#show', as: 'profile'
      get '/users', to: 'accounts#index', as: 'users'
      get '/users/positions', to: 'accounts#positions', as: 'positions'
      get '/:id/unsubscribe', to: 'accounts#unsubscribe', as: 'unsubscribe'
      get '/:id/following', to: 'accounts#following', as: 'following'
      get '/:id/followers', to: 'accounts#followers', as: 'followers'
    end
    
    scope controller: 'static_pages' do
      get '/about', action: 'about', as: 'about'
      get '/privacy', action: 'privacy', as: 'privacy'
      get '/faq', action: 'faq', as: 'faq'
      get '/term', action: 'term', as: 'term'
    end

    get '*path', controller: 'application', action: 'render_404'
end