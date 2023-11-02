Rails.application.routes.draw do
  root to: 'static_pages#home'

  get 'home', to: 'static_pages#home'
  get 'help', to: 'static_pages#help'

  namespace :user do
    get 'signup', to: 'users#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :users
    resources :carts
    resources :carts do
      member do
        get 'edit'
      end
    end
    resources :account_activations, only: :edit
    resources :password_resets, only: %i[new create edit update]
  end

  namespace :admin do
    get 'signup', to: 'admins#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :admins
    resources :categories
    resources :products
    resources :account_activations, only: :edit
    resources :password_resets, only: %i[new create edit update]
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
