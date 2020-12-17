require 'test_helper'

class MarketingTitlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketing_title = marketing_titles(:one)
  end

  test "should get index" do
    get marketing_titles_url, as: :json
    assert_response :success
  end

  test "should create marketing_title" do
    assert_difference('MarketingTitle.count') do
      post marketing_titles_url, params: { marketing_title: { job_name: @marketing_title.job_name } }, as: :json
    end

    assert_response 201
  end

  test "should show marketing_title" do
    get marketing_title_url(@marketing_title), as: :json
    assert_response :success
  end

  test "should update marketing_title" do
    patch marketing_title_url(@marketing_title), params: { marketing_title: { job_name: @marketing_title.job_name } }, as: :json
    assert_response 200
  end

  test "should destroy marketing_title" do
    assert_difference('MarketingTitle.count', -1) do
      delete marketing_title_url(@marketing_title), as: :json
    end

    assert_response 204
  end
end
