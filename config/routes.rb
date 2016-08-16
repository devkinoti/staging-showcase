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
  devise_scope :user do 
    root to: "devise/sessions#new"
  end
  

  devise_for :users
  resource :dashboard, only: [:show]
  resource :import,only: [:show,:products,:line_items,:orders] do 
    collection { get :products }
    collection { get :line_items }
    collection { get :orders }
  end

  resource :store, only: [:show] do 
    collection { get :search, to: "stores#show"} 
  end
  resources :products do 
    collection { post :import }
  end

  resources :carts
  resources :orders do 
    collection { post :import }
  end
  resources :line_items do
    collection { post :import }
    put 'decrement',on: :member
    put 'decrement_mass_product', on: :member
  end
  


end
