require 'test_helper'

class TutorLocationsControllerTest < ActionController::TestCase
  setup do
    @tutor_location = tutor_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tutor_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tutor_location" do
    assert_difference('TutorLocation.count') do
      post :create, tutor_location: { name: @tutor_location.name, university_id: @tutor_location.university_id }
    end

    assert_redirected_to tutor_location_path(assigns(:tutor_location))
  end

  test "should show tutor_location" do
    get :show, id: @tutor_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tutor_location
    assert_response :success
  end

  test "should update tutor_location" do
    put :update, id: @tutor_location, tutor_location: { name: @tutor_location.name, university_id: @tutor_location.university_id }
    assert_redirected_to tutor_location_path(assigns(:tutor_location))
  end

  test "should destroy tutor_location" do
    assert_difference('TutorLocation.count', -1) do
      delete :destroy, id: @tutor_location
    end

    assert_redirected_to tutor_locations_path
  end
end
