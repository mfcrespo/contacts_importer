Rails.application.routes.draw do
  get 'contacts/index'
  devise_for :users
  root "home#index"
  #get "users/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
