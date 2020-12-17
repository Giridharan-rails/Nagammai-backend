require 'test_helper'

class PoSynsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @po_syn = po_syns(:one)
  end

  test "should get index" do
    get po_syns_url, as: :json
    assert_response :success
  end

  test "should create po_syn" do
    assert_difference('PoSyn.count') do
      post po_syns_url, params: { po_syn: { net_amount: @po_syn.net_amount, order_date: @po_syn.order_date, order_no: @po_syn.order_no, quantity: @po_syn.quantity, supplier_name: @po_syn.supplier_name, total_item: @po_syn.total_item } }, as: :json
    end

    assert_response 201
  end

  test "should show po_syn" do
    get po_syn_url(@po_syn), as: :json
    assert_response :success
  end

  test "should update po_syn" do
    patch po_syn_url(@po_syn), params: { po_syn: { net_amount: @po_syn.net_amount, order_date: @po_syn.order_date, order_no: @po_syn.order_no, quantity: @po_syn.quantity, supplier_name: @po_syn.supplier_name, total_item: @po_syn.total_item } }, as: :json
    assert_response 200
  end

  test "should destroy po_syn" do
    assert_difference('PoSyn.count', -1) do
      delete po_syn_url(@po_syn), as: :json
    end

    assert_response 204
  end
end
