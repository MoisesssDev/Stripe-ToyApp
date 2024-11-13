Rails.application.routes.draw do
  resources :stores
  resources :experiences
  resource :stripe_account do
    get :dashboard, to: "stripe_accounts#dashboard", as: "dashboard"
  end
  devise_for :users
  root to: "home#index"
end
