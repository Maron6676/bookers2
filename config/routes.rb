Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/about'

  resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy]
  resources :users, only: [:edit, :index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

