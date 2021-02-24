Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }
  get 'bakers', to: 'users#index'
  resources :products, only: [:new, :create,:edit, :update]
end
