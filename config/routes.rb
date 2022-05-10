Rails.application.routes.draw do
  devise_for :users,
      module: "users",
      path: '',
      path_names: {
      sign_in: 'login', sign_out: 'logout',
      password: 'secret', confirmation: 'verification',
      registration: 'register', edit: 'edit/profile'
    }
  
  root 'pages#index'
  get "pages/show"
  get 'testpages/index'
  get 'testpages/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
