Rails.application.routes.draw do
  namespace :admin do
  	root to: 'base#index'
    get "base/sales",as: :sales
    resource :purchase,only: [:show] do 
      collection { get :search, to: "purchases#show"}
    end
  	resources :users
    resources :expenses
  end

  root to: 'welcome#index', via: :get

  devise_for :users
  resource :dashboard, only: [:show]
  resource :store, only: [:show] do 
    collection { get :search, to: "stores#show"} 
  end
  resources :products
  resources :carts
  resources :orders
  resources :line_items do
    put 'decrement',on: :member
    put 'decrement_mass_product', on: :member
  end
  


end
