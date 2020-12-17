require 'test_helper'

class GoodsReceiptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goods_receipt = goods_receipts(:one)
  end

  test "should get index" do
    get goods_receipts_url, as: :json
    assert_response :success
  end

  test "should create goods_receipt" do
    assert_difference('GoodsReceipt.count') do
      post goods_receipts_url, params: { goods_receipt: { date: @goods_receipt.date, gr_no: @goods_receipt.gr_no, gross_amt: @goods_receipt.gross_amt, invoice_no: @goods_receipt.invoice_no, purchase_order_id: @goods_receipt.purchase_order_id, supplier_id: @goods_receipt.supplier_id } }, as: :json
    end

    assert_response 201
  end

  test "should show goods_receipt" do
    get goods_receipt_url(@goods_receipt), as: :json
    assert_response :success
  end

  test "should update goods_receipt" do
    patch goods_receipt_url(@goods_receipt), params: { goods_receipt: { date: @goods_receipt.date, gr_no: @goods_receipt.gr_no, gross_amt: @goods_receipt.gross_amt, invoice_no: @goods_receipt.invoice_no, purchase_order_id: @goods_receipt.purchase_order_id, supplier_id: @goods_receipt.supplier_id } }, as: :json
    assert_response 200
  end

  test "should destroy goods_receipt" do
    assert_difference('GoodsReceipt.count', -1) do
      delete goods_receipt_url(@goods_receipt), as: :json
    end

    assert_response 204
  end
end
