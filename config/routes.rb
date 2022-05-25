Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  resources :users, only: [:index, :show, :new, :create] do
    resources :posts, only: [:index, :show, :create] do
      resources :comments, only: [:index, :create]
      resources :likes, only: [:index, :create, :destroy]
    end
    resources :followers, only: [:index, :create, :destroy]
  end
end
