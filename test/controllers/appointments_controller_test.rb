require 'test_helper'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get appointments_url, as: :json
    assert_response :success
  end

  test "should create appointment" do
    assert_difference('Appointment.count') do
      post appointments_url, params: { appointment: { appoint_date: @appointment.appoint_date, appoint_note: @appointment.appoint_note, appoint_time: @appointment.appoint_time, contacts_ids: @appointment.contacts_ids, division_id: @appointment.division_id, operating_note: @appointment.operating_note } }, as: :json
    end

    assert_response 201
  end

  test "should show appointment" do
    get appointment_url(@appointment), as: :json
    assert_response :success
  end

  test "should update appointment" do
    patch appointment_url(@appointment), params: { appointment: { appoint_date: @appointment.appoint_date, appoint_note: @appointment.appoint_note, appoint_time: @appointment.appoint_time, contacts_ids: @appointment.contacts_ids, division_id: @appointment.division_id, operating_note: @appointment.operating_note } }, as: :json
    assert_response 200
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete appointment_url(@appointment), as: :json
    end

    assert_response 204
  end
end
