require 'test_helper'

class SendMailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @send_mail = send_mails(:one)
  end

  test "should get index" do
    get send_mails_url, as: :json
    assert_response :success
  end

  test "should create send_mail" do
    assert_difference('SendMail.count') do
      post send_mails_url, params: { send_mail: { job_name: @send_mail.job_name, last_sync: @send_mail.last_sync, schedule: @send_mail.schedule, schedule_period: @send_mail.schedule_period, schedule_time: @send_mail.schedule_time } }, as: :json
    end

    assert_response 201
  end

  test "should show send_mail" do
    get send_mail_url(@send_mail), as: :json
    assert_response :success
  end

  test "should update send_mail" do
    patch send_mail_url(@send_mail), params: { send_mail: { job_name: @send_mail.job_name, last_sync: @send_mail.last_sync, schedule: @send_mail.schedule, schedule_period: @send_mail.schedule_period, schedule_time: @send_mail.schedule_time } }, as: :json
    assert_response 200
  end

  test "should destroy send_mail" do
    assert_difference('SendMail.count', -1) do
      delete send_mail_url(@send_mail), as: :json
    end

    assert_response 204
  end
end
