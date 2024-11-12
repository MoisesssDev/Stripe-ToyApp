class StripeAccountsController < ApplicationController
  def show
  end

  def create
    account = Stripe::Account.create(
    type: "express",
    country: "BR", # Ajuste para o país do anfitrião, como 'BR' para Brasil
    email: current_user.email
    )
    current_user.store.update(stripe_account_id: account.id)

    account_link_url = generate_onboarding_link(account)

    redirect_to account_link_url, status: :see_other, allow_other_host: true
  end

  private

  def generate_onboarding_link(account)
    account_link = Stripe::AccountLink.create({
      account: account.id,
      refresh_url: stripe_account_url,
      return_url: stripe_account_url,
      type: "account_onboarding"
    })

    account_link.url
  end
end
