Rails.application.routes.draw do
  # Devise routes for users with custom registrations controller
  devise_for :users, controllers: {
    registrations: 'users/registrations'
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

  # Admin namespace for static_pages
  namespace :admin do
    resources :static_pages, only: [:edit, :update]
  end
end
