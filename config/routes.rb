# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  resources :users, only: %i[index show new create] do
    resources :posts, only: %i[index show create] do
      resources :comments, only: %i[index create]
      resources :likes, only: %i[index create destroy]
    end
    member do
      get :following, :followers
    end
    resources :feed, only: [:index]
  end
  resources :relationships, only: %i[create destroy]
end
