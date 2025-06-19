Rails.application.routes.draw do
  root "sessions#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "menu_items/search", to: "menu_items#search", as: :search_menu_items
  get "customer/home", to: "pages#customer_home", as: :customer_home
  get "customer/menu", to: "menu_items#customer_index", as: :customer_menu





  get "customer/welcome", to: "pages#customer_welcome", as: :customer_welcome
  get "restaurant/welcome", to: "pages#restaurant_welcome", as: :restaurant_welcome
  get "restaurant/orders", to: "restaurant_orders#index", as: :restaurant_orders
  patch "restaurant/orders/:id/book", to: "restaurant_orders#book", as: :book_order
  get "restaurant/reviews", to: "restaurants#reviews", as: :restaurant_reviews


  get "customer/orders", to: "customer_orders#index", as: :customer_orders
  resources :reviews, only: [:create]
  resources :customer_orders, only: [:index, :destroy]

  resources :restaurant_orders, only: [:index, :update]
  resources :reviews, only: [:create]
  resources :menu_items do
    get 'reviews', to: 'menu_items#reviews'
  end
  resources :restaurants, only: [:show]
  post "bulk_orders", to: "orders#bulk_create", as: :bulk_orders
  resources :menu_items
  resources :cart_items, only: [ :index, :create, :destroy ]
  resources :orders, only: [ :create, :edit, :update ]
  get "order/success", to: "orders#success", as: :order_success
  resources :menu_items do
    resources :reviews, only: [:index]
  end
  
end
