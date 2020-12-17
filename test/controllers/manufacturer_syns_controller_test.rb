require 'test_helper'

class ManufacturerSynsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manufacturer_syn = manufacturer_syns(:one)
  end

  test "should get index" do
    get manufacturer_syns_url, as: :json
    assert_response :success
  end

  test "should create manufacturer_syn" do
    assert_difference('ManufacturerSyn.count') do
      post manufacturer_syns_url, params: { manufacturer_syn: { address: @manufacturer_syn.address, email: @manufacturer_syn.email, name: @manufacturer_syn.name, phone_number: @manufacturer_syn.phone_number } }, as: :json
    end

    assert_response 201
  end

  test "should show manufacturer_syn" do
    get manufacturer_syn_url(@manufacturer_syn), as: :json
    assert_response :success
  end

  test "should update manufacturer_syn" do
    patch manufacturer_syn_url(@manufacturer_syn), params: { manufacturer_syn: { address: @manufacturer_syn.address, email: @manufacturer_syn.email, name: @manufacturer_syn.name, phone_number: @manufacturer_syn.phone_number } }, as: :json
    assert_response 200
  end

  test "should destroy manufacturer_syn" do
    assert_difference('ManufacturerSyn.count', -1) do
      delete manufacturer_syn_url(@manufacturer_syn), as: :json
    end

    assert_response 204
  end
end
