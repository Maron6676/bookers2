Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get  "home/about" => 'homes#about'

  resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy]
  resources :users, only: [:edit, :index, :show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get "search" => "searches#search"
end

