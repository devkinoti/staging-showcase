Rails.application.routes.draw do
  resources :line_items do
    put 'decrement',on: :member
  end

  namespace :admin do
  	root to: 'base#index'
  	resources :users
  end

  root to: 'welcome#index', via: :get

  devise_for :users
  resource :dashboard, only: [:show]
  resource :store, only: [:show]
  resources :products
  resources :carts


end
