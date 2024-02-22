Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'

  root 'home#index'

  namespace :api do
    resources :users
    resources :guesses
    resources :winners

    post 'login', to: 'sessions#create'
  end
end
