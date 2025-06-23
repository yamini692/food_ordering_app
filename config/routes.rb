Rails.application.routes.draw do
  use_doorkeeper
  root to: "sessions#new"

  devise_for :users, skip: [:sessions]

  as :user do
    get    'login',  to: 'sessions#new',     as: :new_user_session
    post   'login',  to: 'sessions#create',  as: :user_session
    delete 'logout', to: 'sessions#destroy', as: :destroy_user_session
  end
  get "menu_items/search", to: "menu_items#search", as: :search_menu_items
  get "customer/home", to: "pages#customer_home", as: :customer_home
  get "customer/menu", to: "menu_items#customer_index", as: :customer_menu
  
  resources :restaurant_orders, only: [:index, :update] do
    member do
      patch :book  # for "Book (On the Way)"
    end
  end
  

  #get "restaurant/orders", to: "restaurant_orders#index", as: :restaurant_orders
  


  get "customer/welcome", to: "pages#customer_welcome", as: :customer_welcome
  get "restaurant/welcome", to: "pages#restaurant_welcome", as: :restaurant_welcome
  #patch "restaurant/orders/:id/book", to: "restaurant_orders#book", as: :book_order
  get "restaurant/reviews", to: "restaurants#reviews", as: :restaurant_reviews


  get "customer/orders", to: "customer_orders#index", as: :customer_orders
  resources :reviews, only: [:create]
  resources :customer_orders, only: [:index, :destroy]
  resources :reviews, only: [:create, :edit, :update]

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
  resources :profiles
  resources :infos, only: [:new, :create, :edit, :update, :show]
  resources :orders do
  resources :reviews, only: [:edit, :update]
end
  namespace :api do
    get 'customer_orders', to: 'customer_orders#api_index'
  end

  #get "/api/customer_orders", to: "customer_orders#api_index"





  
end
