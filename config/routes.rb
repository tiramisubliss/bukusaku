Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: redirect('/admin')
  
  devise_for :users
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources   :articles, :products, :categories, :enquiries
      # Search products name
      get 'products/search/:name', to: "products#search_product"
      # Search detail products
      get 'products/category/:name', to: "categories#search_category"
    end
  end
end
