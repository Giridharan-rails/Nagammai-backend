require 'test_helper'

class PogrSynsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pogr_syn = pogr_syns(:one)
  end

  test "should get index" do
    get pogr_syns_url, as: :json
    assert_response :success
  end

  test "should create pogr_syn" do
    assert_difference('PogrSyn.count') do
      post pogr_syns_url, params: { pogr_syn: { date: @pogr_syn.date, gr_no: @pogr_syn.gr_no, gross_amount: @pogr_syn.gross_amount, invoice_no: @pogr_syn.invoice_no, supplier_name: @pogr_syn.supplier_name } }, as: :json
    end

    assert_response 201
  end

  test "should show pogr_syn" do
    get pogr_syn_url(@pogr_syn), as: :json
    assert_response :success
  end

  test "should update pogr_syn" do
    patch pogr_syn_url(@pogr_syn), params: { pogr_syn: { date: @pogr_syn.date, gr_no: @pogr_syn.gr_no, gross_amount: @pogr_syn.gross_amount, invoice_no: @pogr_syn.invoice_no, supplier_name: @pogr_syn.supplier_name } }, as: :json
    assert_response 200
  end

  test "should destroy pogr_syn" do
    assert_difference('PogrSyn.count', -1) do
      delete pogr_syn_url(@pogr_syn), as: :json
    end

    assert_response 204
  end
end
