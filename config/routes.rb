# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # get 'posts'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts, :users do
    resources :comments
  end
  post 'post/:id/likes', to: 'posts#like', as: :likes
  post 'post/:id/unlikes', to: 'posts#unlike', as: :unlikes
end
