Rails.application.routes.draw do
  namespace :admin do
  	root to: 'base#index'
  	resources :users
    resources :expenses
  end

  root to: 'welcome#index', via: :get

  devise_for :users
  resource :dashboard, only: [:show]
  resource :store, only: [:show]
  resources :products
  resources :carts
  resources :orders
  resources :line_items do
    put 'decrement',on: :member
  end
  


end
