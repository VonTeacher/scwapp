Rails.application.routes.draw do

  root 'users#index'

  # CLUBS
  resources :clubs do
    resources :tees, only: [:new, :create, :edit, :update, :destroy]
  end

  # USERS
  get  '/users', to: 'users#index'
  get  '/signup', to: 'users#new'
  post '/users', to: 'users#create'
  resources :users, only: [:show, :edit, :update]

  # SESSIONS
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  get    '/logout', to: 'sessions#destroy'

  # ROUNDS
  get   '/add_round', to: 'rounds#new'
  post  '/add_round', to: 'rounds#create'
  resources :rounds, only: [:edit, :update, :destroy]

end
