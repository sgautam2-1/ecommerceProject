require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get checkout_new_url
    assert_response :success
  end

  test "should get create" do
    get checkout_create_url
    assert_response :success
  end

  test "should get show" do
    get checkout_show_url
    assert_response :success
  end

  test "should get payment" do
    get checkout_payment_url
    assert_response :success
  end
end
