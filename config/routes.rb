Rails.application.routes.draw do
  resources :batches, only: [ :new, :create ]
  resources :stores
  resources :experiences

  resource :stripe_account, only: [ :show, :update, :create ]
  devise_for :users
  root to: "home#index"

  namespace :webhooks do
    resources :stripe, only: [ :create ]
  end
end
