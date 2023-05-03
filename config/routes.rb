Rails.application.routes.draw do
  get 'favorites/index'
  devise_for :users
  root to: 'homes#top'
  get  "home/about" => 'homes#about'

  resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy] do
    resources :book_comments, only:[:create, :destroy]
  end
  resources :users, only: [:edit, :index, :show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get "search" => "searches#search"
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
end

