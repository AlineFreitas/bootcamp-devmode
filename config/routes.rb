Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'about', action: :about, controller: 'pages'
  resources :tweets, only: [:create, :show]
  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]
end