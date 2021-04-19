Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users
  resources :contacts
  resources :import_contacts do
    collection { post :import }  
  end
  resources :rejected_contacts, only: [:index]
  root "home#index"
  
end
