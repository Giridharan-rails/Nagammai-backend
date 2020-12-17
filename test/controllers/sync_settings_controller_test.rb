require 'test_helper'

class SyncSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sync_setting = sync_settings(:one)
  end

  test "should get index" do
    get sync_settings_url, as: :json
    assert_response :success
  end

  test "should create sync_setting" do
    assert_difference('SyncSetting.count') do
      post sync_settings_url, params: { sync_setting: { job_name: @sync_setting.job_name, last_sync: @sync_setting.last_sync, schedule: @sync_setting.schedule, schedule_period: @sync_setting.schedule_period, schedule_time: @sync_setting.schedule_time } }, as: :json
    end

    assert_response 201
  end

  test "should show sync_setting" do
    get sync_setting_url(@sync_setting), as: :json
    assert_response :success
  end

  test "should update sync_setting" do
    patch sync_setting_url(@sync_setting), params: { sync_setting: { job_name: @sync_setting.job_name, last_sync: @sync_setting.last_sync, schedule: @sync_setting.schedule, schedule_period: @sync_setting.schedule_period, schedule_time: @sync_setting.schedule_time } }, as: :json
    assert_response 200
  end

  test "should destroy sync_setting" do
    assert_difference('SyncSetting.count', -1) do
      delete sync_setting_url(@sync_setting), as: :json
    end

    assert_response 204
  end
end
