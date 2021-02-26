Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }
  get '/bakers/:name', to: 'users#show_shop', as: 'baker'
  get 'bakers', to: 'users#index'
  get '/orders', to: 'orders#index', as: 'orders'
  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#new'
  get '/sales', to: 'orders#sales'
  get '/search', to: 'pages#search'
  resources :products, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only:[:edit, :update]
  resources :orders, only: [:new, :edit, :update]
end
