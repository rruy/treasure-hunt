Rails.application.routes.draw do
  get 'treasure_locations/index'
  get 'treasure_locations/show'
  get 'treasure_locations/create'
  get 'treasure_locations/update'
  get 'treasure_locations/destroy'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'

  root 'home#index'

  namespace :api do
    resources :users
    resources :guesses
    resources :winners
    resources :treasure_locations

    post 'login', to: 'sessions#create'
  end
end
