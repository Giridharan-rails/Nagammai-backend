require 'test_helper'

class SupplierSynsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplier_syn = supplier_syns(:one)
  end

  test "should get index" do
    get supplier_syns_url, as: :json
    assert_response :success
  end

  test "should create supplier_syn" do
    assert_difference('SupplierSyn.count') do
      post supplier_syns_url, params: { supplier_syn: { address: @supplier_syn.address, email: @supplier_syn.email, name: @supplier_syn.name, phone_number: @supplier_syn.phone_number } }, as: :json
    end

    assert_response 201
  end

  test "should show supplier_syn" do
    get supplier_syn_url(@supplier_syn), as: :json
    assert_response :success
  end

  test "should update supplier_syn" do
    patch supplier_syn_url(@supplier_syn), params: { supplier_syn: { address: @supplier_syn.address, email: @supplier_syn.email, name: @supplier_syn.name, phone_number: @supplier_syn.phone_number } }, as: :json
    assert_response 200
  end

  test "should destroy supplier_syn" do
    assert_difference('SupplierSyn.count', -1) do
      delete supplier_syn_url(@supplier_syn), as: :json
    end

    assert_response 204
  end
end
