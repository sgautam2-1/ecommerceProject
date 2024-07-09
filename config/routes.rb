Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'home#index'

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  resources :products, only: [:index, :show] do
    collection do
      get 'new_arrivals', to: 'products#new_arrivals'
      get 'recently_updated', to: 'products#recently_updated'
    end
  end

  resources :categories, only: [:index, :show]
  
  namespace :admin do
    resources :static_pages, only: [:edit, :update]
  end
end
