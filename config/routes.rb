# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'devise/sessions'  # Ensure sessions controller is correctly set up
  }

  # Custom sign out route
  devise_scope :user do
    delete 'users/sign_out', to: 'devise/sessions#destroy'
  end

  # ActiveAdmin routes for admin_users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root route
  root 'home#index'

  # Static pages routes
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # Products routes
  resources :products, only: [:index, :show] do
    collection do
      get 'new_arrivals', to: 'products#new_arrivals'
      get 'recently_updated', to: 'products#recently_updated'
    end
  end

  # Categories routes
  resources :categories, only: [:index, :show]

  # Cart routes
  resource :cart, only: [:show] do
    collection do
      post 'add_item'
      delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
      patch 'update_quantity', to: 'carts#update_quantity', as: 'update_quantity'
      get 'checkout', to: 'carts#checkout', as: 'checkout'
    end
  end

  # Orders routes
  resources :orders, only: [:index, :show]

  # Checkout routes
  resources :checkout, only: [:new, :create, :show] do
    member do
      post 'payment'
    end
  end

  # Addresses routes
  resources :addresses, only: [:new, :create]

  # Admin namespace for static_pages
  namespace :admin do
    resources :static_pages, only: [:edit, :update]
  end
end
