Rails.application.routes.draw do
  get "/artists", to: "users#index", as: :artists
  get 'users/account'
  get 'users/ticket'
  get 'users/manage'
  patch 'users/update'
  devise_for :users
  root to: 'events#index'
  get "users/:id", to: "users#show", as: :profile
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'about', to: 'pages#about', as: :about

  get 'how', to: 'pages#how', as: :how

  get 'contact', to: 'pages#contact', as: :contact

  get 'apply-artist', to: 'pages#apply-artist', as: :applyartist

  get 'apply-venue', to: 'pages#apply-venue', as: :applyvenue

  get 'artists-featured', to: 'pages#artists-featured', as: :artistsfeatured

  get 'nearme', to: 'events#nearme', as: :nearme

  get 'searchcity', to: 'events#searchcity'

  get 'search', to: 'events#search'

  post 'order/payment', to: "orders#payment", as: :payment
  post 'order/deposit', to: "orders#deposit", as: :deposit
  post 'order/deposit', to: "orders#deposit", as: :donate_amount
  post 'order/paymentlive', to: "orders#paymentlive", as: :paymentlive

  resources :events do
    resources :event_attendees, only: [:create]
  end

  resources :rooms

  resources :orders, only: [:show] do
    resources :payments, only: :new
  end

 resources :chatrooms, only: :show do
  resources :messages, only: :create
end


mount StripeEvent::Engine, at: '/stripe-webhooks'

end

