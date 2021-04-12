Rails.application.routes.draw do
  
  devise_for :users
  get 'contacts/index'
  resources :contacts do
    collection { post :import }
  end
  root "home#index"
  
  #get "users/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
