Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :v1 do 
    resources :products
  	resources :articles
  	resources :categories

  	#Search products name
  	get 'products/search/:name', to: "products#search_product"
  	#Search detail products
  	get 'products/category/:name', to: "categories#search_category"

  end
end
