require 'test_helper'

class ManufacturersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manufacturer = manufacturers(:one)
  end

  test "should get index" do
    get manufacturers_url, as: :json
    assert_response :success
  end

  test "should create manufacturer" do
    assert_difference('Manufacturer.count') do
      post manufacturers_url, params: { manufacturer: { address: @manufacturer.address, email: @manufacturer.email, name: @manufacturer.name, phone_number: @manufacturer.phone_number, supplier_id: @manufacturer.supplier_id } }, as: :json
    end

    assert_response 201
  end

  test "should show manufacturer" do
    get manufacturer_url(@manufacturer), as: :json
    assert_response :success
  end

  test "should update manufacturer" do
    patch manufacturer_url(@manufacturer), params: { manufacturer: { address: @manufacturer.address, email: @manufacturer.email, name: @manufacturer.name, phone_number: @manufacturer.phone_number, supplier_id: @manufacturer.supplier_id } }, as: :json
    assert_response 200
  end

  test "should destroy manufacturer" do
    assert_difference('Manufacturer.count', -1) do
      delete manufacturer_url(@manufacturer), as: :json
    end

    assert_response 204
  end
end
