Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :v1 do 
  	root 'products#index'

  	resources :products
  	resources :articles
  	resources :categories


  	post 'products?category=', to: "products#index"
  	post 'products/search', to: "products#search"


  end
end
