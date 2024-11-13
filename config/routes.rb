Rails.application.routes.draw do
  resource :stripe_account do
    get :dashboard, to: "stripe_accounts#dashboard", as: "dashboard"
  end
  devise_for :users
  root to: "home#index"
end
