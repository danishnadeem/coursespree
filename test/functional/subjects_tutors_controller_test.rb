require 'test_helper'

class SubjectsTutorsControllerTest < ActionController::TestCase
  setup do
    @subjects_tutor = subjects_tutors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects_tutors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subjects_tutor" do
    assert_difference('SubjectsTutor.count') do
      post :create, subjects_tutor: { subject_id: @subjects_tutor.subject_id, tutor_id: @subjects_tutor.tutor_id }
    end

    assert_redirected_to subjects_tutor_path(assigns(:subjects_tutor))
  end

  test "should show subjects_tutor" do
    get :show, id: @subjects_tutor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subjects_tutor
    assert_response :success
  end

  test "should update subjects_tutor" do
    put :update, id: @subjects_tutor, subjects_tutor: { subject_id: @subjects_tutor.subject_id, tutor_id: @subjects_tutor.tutor_id }
    assert_redirected_to subjects_tutor_path(assigns(:subjects_tutor))
  end

  test "should destroy subjects_tutor" do
    assert_difference('SubjectsTutor.count', -1) do
      delete :destroy, id: @subjects_tutor
    end

    assert_redirected_to subjects_tutors_path
  end
end
