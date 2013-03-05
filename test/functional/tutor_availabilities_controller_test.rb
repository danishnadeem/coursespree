require 'test_helper'

class TutorAvailabilitiesControllerTest < ActionController::TestCase
  setup do
    @tutor_availability = tutor_availabilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tutor_availabilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tutor_availability" do
    assert_difference('TutorAvailability.count') do
      post :create, tutor_availability: { time_end: @tutor_availability.time_end, time_start: @tutor_availability.time_start, tutor_id: @tutor_availability.tutor_id, weekly: @tutor_availability.weekly }
    end

    assert_redirected_to tutor_availability_path(assigns(:tutor_availability))
  end

  test "should show tutor_availability" do
    get :show, id: @tutor_availability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tutor_availability
    assert_response :success
  end

  test "should update tutor_availability" do
    put :update, id: @tutor_availability, tutor_availability: { time_end: @tutor_availability.time_end, time_start: @tutor_availability.time_start, tutor_id: @tutor_availability.tutor_id, weekly: @tutor_availability.weekly }
    assert_redirected_to tutor_availability_path(assigns(:tutor_availability))
  end

  test "should destroy tutor_availability" do
    assert_difference('TutorAvailability.count', -1) do
      delete :destroy, id: @tutor_availability
    end

    assert_redirected_to tutor_availabilities_path
  end
end
