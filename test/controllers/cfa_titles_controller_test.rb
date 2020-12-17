require 'test_helper'

class CfaTitlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cfa_title = cfa_titles(:one)
  end

  test "should get index" do
    get cfa_titles_url, as: :json
    assert_response :success
  end

  test "should create cfa_title" do
    assert_difference('CfaTitle.count') do
      post cfa_titles_url, params: { cfa_title: { job_name: @cfa_title.job_name } }, as: :json
    end

    assert_response 201
  end

  test "should show cfa_title" do
    get cfa_title_url(@cfa_title), as: :json
    assert_response :success
  end

  test "should update cfa_title" do
    patch cfa_title_url(@cfa_title), params: { cfa_title: { job_name: @cfa_title.job_name } }, as: :json
    assert_response 200
  end

  test "should destroy cfa_title" do
    assert_difference('CfaTitle.count', -1) do
      delete cfa_title_url(@cfa_title), as: :json
    end

    assert_response 204
  end
end
