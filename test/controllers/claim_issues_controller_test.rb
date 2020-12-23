require 'test_helper'

class ClaimIssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @claim_issue = claim_issues(:one)
  end

  test "should get index" do
    get claim_issues_url, as: :json
    assert_response :success
  end

  test "should create claim_issue" do
    assert_difference('ClaimIssue.count') do
      post claim_issues_url, params: { claim_issue: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show claim_issue" do
    get claim_issue_url(@claim_issue), as: :json
    assert_response :success
  end

  test "should update claim_issue" do
    patch claim_issue_url(@claim_issue), params: { claim_issue: {  } }, as: :json
    assert_response 200
  end

  test "should destroy claim_issue" do
    assert_difference('ClaimIssue.count', -1) do
      delete claim_issue_url(@claim_issue), as: :json
    end

    assert_response 204
  end
end
