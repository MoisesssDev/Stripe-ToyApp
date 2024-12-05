Rails.application.routes.draw do
  resources :batches, only: [ :new, :create ]
  resources :stores
  resources :experiences
  resources :checkouts, only: [ :create ]
  resources :bookings, only: [ :index ]

  resources :stripe_account, only: [ :show, :update, :create ]
  resources :refunds, only: [ :create ]

  devise_for :users
  root to: "home#index"

  namespace :webhooks do
    resources :stripe, only: [ :create ]
  end
end
