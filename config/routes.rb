Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :orders
  root :to => 'dashboard#index'
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
