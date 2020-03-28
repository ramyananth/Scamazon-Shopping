Rails.application.routes.draw do
  get 'user/index'
  get 'user/show'
  get 'user/destroy'
  get 'user/update'
  get 'user/create'
  get 'user/edit'
  get 'admin/index'
  get 'admin/show'
  devise_for :admins
  # devise_for :admins, :controllers => {
  #     :registrations => "admins/registrations",
  #     :sessions => "admins/sessions",
  #     :passwords => "admins/passwords",
  #     :confirmations => "admins/confirmations",
     
  # }

  # devise_scope :admin do
  #   get 'sign_up', to: 'admins/registrations#new'
  #   get 'sign_in' , to: 'admins/sessions#new'
  #   delete 'sign_out', to: 'admins/sessions#destroy'
  #   resources :admins
  #   end
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  resources :taxes
  resources :feedbacks
  resources :wishlist_items
  resource :wishlists, only:[:show] do
    put 'add/:item_id', to: 'wishlists#add', as: :add_to
    put 'remove/:item_id', to: 'wishlists#remove', as: :remove_from
    put 'remove_one/:item_id', to: 'wishlists#removeone', as: :remove_one
  end 
  resources :order_items
  resources :statuses
  resources :orders
  resources :payments
  resources :categories, only: [:index, :show]
  resources :items
  resources :items 
  get '/subscription/', to: 'items#subscription', as: 'subscription'
  resources :item_categories
  resources :cart_items, only: [:create, :update, :destroy]
  resource :carts, only:[:show] do
    put 'add/:item_id', to: 'carts#add', as: :add_to
    put 'remove/:item_id', to: 'carts#remove', as: :remove_from
    put 'remove_one/:item_id', to: 'carts#removeone', as: :remove_one
  end 
  # authenticated :user do
  #   if current_admin
  #     root to: "admin#show", as: :authenticated_root
  #   else
  #     root to: "categories#index", as: :authenticated_root
  #   end
  # end

  root to:"items#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # resources :articles do
  #  resources :comments
  # end

  # resources :articles 
  get "carts/:id/clear_all", to: "carts#clear_all"
  # resources :articles
  
  resources :items do
    member do
      delete :delete_image
    end
  end
end
