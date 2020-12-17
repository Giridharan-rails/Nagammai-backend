require 'test_helper'

class GoodsReceivedNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goods_received_note = goods_received_notes(:one)
  end

  test "should get index" do
    get goods_received_notes_url, as: :json
    assert_response :success
  end

  test "should create goods_received_note" do
    assert_difference('GoodsReceivedNote.count') do
      post goods_received_notes_url, params: { goods_received_note: { amount: @goods_received_note.amount, batch_description: @goods_received_note.batch_description, free_qunatity: @goods_received_note.free_qunatity, grn_date: @goods_received_note.grn_date, grn_number: @goods_received_note.grn_number, gross: @goods_received_note.gross, invoice_date: @goods_received_note.invoice_date, invoice_number: @goods_received_note.invoice_number, mrp: @goods_received_note.mrp, product_code: @goods_received_note.product_code, product_id: @goods_received_note.product_id, product_name: @goods_received_note.product_name, purchase_price: @goods_received_note.purchase_price, purchase_taxcode: @goods_received_note.purchase_taxcode, quantity: @goods_received_note.quantity, remarks: @goods_received_note.remarks, supplier_code: @goods_received_note.supplier_code, supplier_gstnumber: @goods_received_note.supplier_gstnumber, supplier_id: @goods_received_note.supplier_id, supplier_name: @goods_received_note.supplier_name, tax: @goods_received_note.tax } }, as: :json
    end

    assert_response 201
  end

  test "should show goods_received_note" do
    get goods_received_note_url(@goods_received_note), as: :json
    assert_response :success
  end

  test "should update goods_received_note" do
    patch goods_received_note_url(@goods_received_note), params: { goods_received_note: { amount: @goods_received_note.amount, batch_description: @goods_received_note.batch_description, free_qunatity: @goods_received_note.free_qunatity, grn_date: @goods_received_note.grn_date, grn_number: @goods_received_note.grn_number, gross: @goods_received_note.gross, invoice_date: @goods_received_note.invoice_date, invoice_number: @goods_received_note.invoice_number, mrp: @goods_received_note.mrp, product_code: @goods_received_note.product_code, product_id: @goods_received_note.product_id, product_name: @goods_received_note.product_name, purchase_price: @goods_received_note.purchase_price, purchase_taxcode: @goods_received_note.purchase_taxcode, quantity: @goods_received_note.quantity, remarks: @goods_received_note.remarks, supplier_code: @goods_received_note.supplier_code, supplier_gstnumber: @goods_received_note.supplier_gstnumber, supplier_id: @goods_received_note.supplier_id, supplier_name: @goods_received_note.supplier_name, tax: @goods_received_note.tax } }, as: :json
    assert_response 200
  end

  test "should destroy goods_received_note" do
    assert_difference('GoodsReceivedNote.count', -1) do
      delete goods_received_note_url(@goods_received_note), as: :json
    end

    assert_response 204
  end
end
