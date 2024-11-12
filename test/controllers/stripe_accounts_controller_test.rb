require "test_helper"

class StripeAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get stripe_accounts_show_url
    assert_response :success
  end
end
