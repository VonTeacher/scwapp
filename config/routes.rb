Rails.application.routes.draw do

  root 'clubs#index'

  resources :clubs do
    resources :tees, only: [:new, :create]
  end

  # USERS
  get '/signup', to: 'users#new'

end
