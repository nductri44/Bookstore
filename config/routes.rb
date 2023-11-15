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
    resources :categories
    resources :products
    resources :carts do
      collection do
        post 'add_to_cart', to: 'carts#add_to_cart'
        patch 'update_cart', to: 'carts#update_cart'
      end
    end
    resources :orders
    resources :account_activations, only: :edit
    resources :password_resets, only: %i[new create edit update]
  end

  namespace :admin do
    get '/', to: 'static_pages#home'
    get 'signup', to: 'admins#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :admins
    resources :categories
    resources :products
    resources :orders
    resources :account_activations, only: :edit
    resources :password_resets, only: %i[new create edit update]
  end

  get '*all',
      to: redirect { |_, req| "/?404=#{req.path}" },
      constraints: lambda { |req|
                     req.path.exclude?('rails/active_storage')
                   }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
