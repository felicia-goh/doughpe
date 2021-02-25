Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }
  get '/bakers/:name', to: 'users#show_shop', as: 'baker'
  get 'bakers', to: 'users#index'
  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#new'
  get '/sales', to: 'orders#sales'
  resources :products, only: [:new, :create, :edit, :update]
  resources :users, only:[:edit, :update]
  resources :orders, only: [:index]
end
