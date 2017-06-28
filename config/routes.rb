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

  # SESSIONS
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
