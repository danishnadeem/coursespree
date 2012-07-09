require 'test_helper'

class MeetingsControllerTest < ActionController::TestCase
  setup do
    @meeting = meetings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meetings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting" do
    assert_difference('Meeting.count') do
      post :create, meeting: { accept: @meeting.accept, attendeePW: @meeting.attendeePW, classlink: @meeting.classlink, duration: @meeting.duration, moderatorPW: @meeting.moderatorPW, name: @meeting.name, price: @meeting.price, rating: @meeting.rating, start_time: @meeting.start_time, subject: @meeting.subject, tutor_id: @meeting.tutor_id, user_id: @meeting.user_id }
    end

    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should show meeting" do
    get :show, id: @meeting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting
    assert_response :success
  end

  test "should update meeting" do
    put :update, id: @meeting, meeting: { accept: @meeting.accept, attendeePW: @meeting.attendeePW, classlink: @meeting.classlink, duration: @meeting.duration, moderatorPW: @meeting.moderatorPW, name: @meeting.name, price: @meeting.price, rating: @meeting.rating, start_time: @meeting.start_time, subject: @meeting.subject, tutor_id: @meeting.tutor_id, user_id: @meeting.user_id }
    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should destroy meeting" do
    assert_difference('Meeting.count', -1) do
      delete :destroy, id: @meeting
    end

    assert_redirected_to meetings_path
  end
end
