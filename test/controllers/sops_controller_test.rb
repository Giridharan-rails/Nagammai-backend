require 'test_helper'

class SopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sop = sops(:one)
  end

  test "should get index" do
    get sops_url, as: :json
    assert_response :success
  end

  test "should create sop" do
    assert_difference('Sop.count') do
      post sops_url, params: { sop: { claims_offer: @sop.claims_offer, current_ms: @sop.current_ms, current_ns: @sop.current_ns, delivery_order_schedule: @sop.delivery_order_schedule, dispatch_mode: @sop.dispatch_mode, division_id: @sop.division_id, expiry_broken_settlement: @sop.expiry_broken_settlement, monthly_appoinment1: @sop.monthly_appoinment1, monthly_appoinment2: @sop.monthly_appoinment2, order_type: @sop.order_type, payment_term: @sop.payment_term, special_offer: @sop.special_offer } }, as: :json
    end

    assert_response 201
  end

  test "should show sop" do
    get sop_url(@sop), as: :json
    assert_response :success
  end

  test "should update sop" do
    patch sop_url(@sop), params: { sop: { claims_offer: @sop.claims_offer, current_ms: @sop.current_ms, current_ns: @sop.current_ns, delivery_order_schedule: @sop.delivery_order_schedule, dispatch_mode: @sop.dispatch_mode, division_id: @sop.division_id, expiry_broken_settlement: @sop.expiry_broken_settlement, monthly_appoinment1: @sop.monthly_appoinment1, monthly_appoinment2: @sop.monthly_appoinment2, order_type: @sop.order_type, payment_term: @sop.payment_term, special_offer: @sop.special_offer } }, as: :json
    assert_response 200
  end

  test "should destroy sop" do
    assert_difference('Sop.count', -1) do
      delete sop_url(@sop), as: :json
    end

    assert_response 204
  end
end
