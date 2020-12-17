require 'test_helper'

class PaymentTermsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment_term = payment_terms(:one)
  end

  test "should get index" do
    get payment_terms_url, as: :json
    assert_response :success
  end

  test "should create payment_term" do
    assert_difference('PaymentTerm.count') do
      post payment_terms_url, params: { payment_term: { job_name: @payment_term.job_name } }, as: :json
    end

    assert_response 201
  end

  test "should show payment_term" do
    get payment_term_url(@payment_term), as: :json
    assert_response :success
  end

  test "should update payment_term" do
    patch payment_term_url(@payment_term), params: { payment_term: { job_name: @payment_term.job_name } }, as: :json
    assert_response 200
  end

  test "should destroy payment_term" do
    assert_difference('PaymentTerm.count', -1) do
      delete payment_term_url(@payment_term), as: :json
    end

    assert_response 204
  end
end
