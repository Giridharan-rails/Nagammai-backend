require 'test_helper'

class DivisionSynsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @division_syn = division_syns(:one)
  end

  test "should get index" do
    get division_syns_url, as: :json
    assert_response :success
  end

  test "should create division_syn" do
    assert_difference('DivisionSyn.count') do
      post division_syns_url, params: { division_syn: { address: @division_syn.address, email: @division_syn.email, name: @division_syn.name, phone_number: @division_syn.phone_number } }, as: :json
    end

    assert_response 201
  end

  test "should show division_syn" do
    get division_syn_url(@division_syn), as: :json
    assert_response :success
  end

  test "should update division_syn" do
    patch division_syn_url(@division_syn), params: { division_syn: { address: @division_syn.address, email: @division_syn.email, name: @division_syn.name, phone_number: @division_syn.phone_number } }, as: :json
    assert_response 200
  end

  test "should destroy division_syn" do
    assert_difference('DivisionSyn.count', -1) do
      delete division_syn_url(@division_syn), as: :json
    end

    assert_response 204
  end
end
