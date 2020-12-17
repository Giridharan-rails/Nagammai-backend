require 'test_helper'

class AdjustmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adjustment = adjustments(:one)
  end

  test "should get index" do
    get adjustments_url, as: :json
    assert_response :success
  end

  test "should create adjustment" do
    assert_difference('Adjustment.count') do
      post adjustments_url, params: { adjustment: { adjust_quantity: @adjustment.adjust_quantity, balance_amount: @adjustment.balance_amount, claim_product_id: @adjustment.claim_product_id, claim_product_type: @adjustment.claim_product_type, credit_date: @adjustment.credit_date, credit_note_num: @adjustment.credit_note_num, remark: @adjustment.remark, settled_amount: @adjustment.settled_amount } }, as: :json
    end

    assert_response 201
  end

  test "should show adjustment" do
    get adjustment_url(@adjustment), as: :json
    assert_response :success
  end

  test "should update adjustment" do
    patch adjustment_url(@adjustment), params: { adjustment: { adjust_quantity: @adjustment.adjust_quantity, balance_amount: @adjustment.balance_amount, claim_product_id: @adjustment.claim_product_id, claim_product_type: @adjustment.claim_product_type, credit_date: @adjustment.credit_date, credit_note_num: @adjustment.credit_note_num, remark: @adjustment.remark, settled_amount: @adjustment.settled_amount } }, as: :json
    assert_response 200
  end

  test "should destroy adjustment" do
    assert_difference('Adjustment.count', -1) do
      delete adjustment_url(@adjustment), as: :json
    end

    assert_response 204
  end
end
