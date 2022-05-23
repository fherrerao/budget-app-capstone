Rails.application.routes.draw do
  devise_for :users
  resources :groups
  resources :home_page, only: [:index]  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home_page#index"
end
