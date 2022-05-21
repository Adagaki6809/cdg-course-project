Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  resources :users do
    resources :posts, only: [:index, :show, :create]
  end
  #resources :posts, only: [:index, :show, :new, :create]
  resources :followers
  resources :likes
  resources :comments
end
