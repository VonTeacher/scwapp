Rails.application.routes.draw do

  root 'clubs#index'

  resources :clubs do
    resources :tees, only: [:new, :create]
  end

  # USERS

  get '/users', to: 'users#index'
  
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'


  resources :users, only: [:show]

end
