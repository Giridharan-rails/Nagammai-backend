require 'test_helper'

class ReceiveMailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @receive_mail = receive_mails(:one)
  end

  test "should get index" do
    get receive_mails_url, as: :json
    assert_response :success
  end

  test "should create receive_mail" do
    assert_difference('ReceiveMail.count') do
      post receive_mails_url, params: { receive_mail: { job_name: @receive_mail.job_name, last_sync: @receive_mail.last_sync, schedule: @receive_mail.schedule, schedule_period: @receive_mail.schedule_period, schedule_time: @receive_mail.schedule_time } }, as: :json
    end

    assert_response 201
  end

  test "should show receive_mail" do
    get receive_mail_url(@receive_mail), as: :json
    assert_response :success
  end

  test "should update receive_mail" do
    patch receive_mail_url(@receive_mail), params: { receive_mail: { job_name: @receive_mail.job_name, last_sync: @receive_mail.last_sync, schedule: @receive_mail.schedule, schedule_period: @receive_mail.schedule_period, schedule_time: @receive_mail.schedule_time } }, as: :json
    assert_response 200
  end

  test "should destroy receive_mail" do
    assert_difference('ReceiveMail.count', -1) do
      delete receive_mail_url(@receive_mail), as: :json
    end

    assert_response 204
  end
end
