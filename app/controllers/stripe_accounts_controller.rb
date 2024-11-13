class StripeAccountsController < ApplicationController
  def show
  end

  def finish_stripe_account
    account_link_url = generate_onboarding_link
    redirect_to account_link_url, status: :see_other, allow_other_host: true
  end

  def dashboard
    account = Stripe::Account.retrieve(current_user.store.stripe_account_id)
    login_links = account.login_links.create

    redirect_to login_links.url
  end

  def create
    account = Stripe::Account.create(
    type: "express",
    country: "BR", # Ajuste para o país do anfitrião, como 'BR' para Brasil
    email: current_user.email
    )
    current_user.store.update(stripe_account_id: account.id)

    account_link_url = generate_onboarding_link
    redirect_to account_link_url, status: :see_other, allow_other_host: true
  end

  private

  def generate_onboarding_link
    account_link = Stripe::AccountLink.create({
      account: current_user.store.stripe_account_id,
      refresh_url: store_url(current_user.store),
      return_url: store_url(current_user.store),
      type: "account_onboarding"
    })

    account_link.url
  end
end
