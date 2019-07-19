Rails.application.routes.draw do
	resources :payments
	devise_for :users, controllers: { registrations: "registrations" }
	resources :orders do 
		member do 
			get 'payment'
			post 'save_payment'
		end
	end
	root :to => 'dashboard#index'
	resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
