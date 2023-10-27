Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'account_activations/edit'
  root to: 'static_pages#home'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :admin_shops
  resources :users
  resources :account_activations, only: :edit

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
