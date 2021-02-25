Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }
  get '/bakers/:name', to: 'users#show_shop', as: 'baker'
  get 'bakers', to: 'users#index'
  get '/orders', to: 'orders#new'
  post '/orders', to: 'orders#new'
  resources :products, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only:[:edit, :update]
end
