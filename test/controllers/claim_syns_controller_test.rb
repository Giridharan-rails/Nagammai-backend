require 'test_helper'

class ClaimSynsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @claim_syn = claim_syns(:one)
  end

  test "should get index" do
    get claim_syns_url, as: :json
    assert_response :success
  end

  test "should create claim_syn" do
    assert_difference('ClaimSyn.count') do
      post claim_syns_url, params: { claim_syn: { batch_desc: @claim_syn.batch_desc, bill_date: @claim_syn.bill_date, bill_number: @claim_syn.bill_number, describtion: @claim_syn.describtion, expiry_date: @claim_syn.expiry_date, p_code: @claim_syn.p_code, packing: @claim_syn.packing, quantity: @claim_syn.quantity } }, as: :json
    end

    assert_response 201
  end

  test "should show claim_syn" do
    get claim_syn_url(@claim_syn), as: :json
    assert_response :success
  end

  test "should update claim_syn" do
    patch claim_syn_url(@claim_syn), params: { claim_syn: { batch_desc: @claim_syn.batch_desc, bill_date: @claim_syn.bill_date, bill_number: @claim_syn.bill_number, describtion: @claim_syn.describtion, expiry_date: @claim_syn.expiry_date, p_code: @claim_syn.p_code, packing: @claim_syn.packing, quantity: @claim_syn.quantity } }, as: :json
    assert_response 200
  end

  test "should destroy claim_syn" do
    assert_difference('ClaimSyn.count', -1) do
      delete claim_syn_url(@claim_syn), as: :json
    end

    assert_response 204
  end
end
