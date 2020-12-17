require 'test_helper'

class ClaimsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @claim = claims(:one)
  end

  test "should get index" do
    get claims_url, as: :json
    assert_response :success
  end

  test "should create claim" do
    assert_difference('Claim.count') do
      post claims_url, params: { claim: { amount: @claim.amount, batch_desc: @claim.batch_desc, bill_date: @claim.bill_date, bill_number: @claim.bill_number, description: @claim.description, division_id: @claim.division_id, expiry_date: @claim.expiry_date, packing: @claim.packing, purchase_code: @claim.purchase_code, quantity: @claim.quantity, status: @claim.status, type_of_claim: @claim.type_of_claim } }, as: :json
    end

    assert_response 201
  end

  test "should show claim" do
    get claim_url(@claim), as: :json
    assert_response :success
  end

  test "should update claim" do
    patch claim_url(@claim), params: { claim: { amount: @claim.amount, batch_desc: @claim.batch_desc, bill_date: @claim.bill_date, bill_number: @claim.bill_number, description: @claim.description, division_id: @claim.division_id, expiry_date: @claim.expiry_date, packing: @claim.packing, purchase_code: @claim.purchase_code, quantity: @claim.quantity, status: @claim.status, type_of_claim: @claim.type_of_claim } }, as: :json
    assert_response 200
  end

  test "should destroy claim" do
    assert_difference('Claim.count', -1) do
      delete claim_url(@claim), as: :json
    end

    assert_response 204
  end
end
