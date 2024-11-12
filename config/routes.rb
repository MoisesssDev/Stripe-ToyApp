Rails.application.routes.draw do
  resource :stripe_account
  devise_for :users
  root to: "home#index"
end
