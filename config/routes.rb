Rails.application.routes.draw do

  root 'posts#index'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  resources :posts
  resources :users

  get '/signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
