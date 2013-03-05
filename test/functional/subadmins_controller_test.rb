require 'test_helper'

class SubadminsControllerTest < ActionController::TestCase
  setup do
    @subadmin = subadmins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subadmins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subadmin" do
    assert_difference('Subadmin.count') do
      post :create, subadmin: {  }
    end

    assert_redirected_to subadmin_path(assigns(:subadmin))
  end

  test "should show subadmin" do
    get :show, id: @subadmin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subadmin
    assert_response :success
  end

  test "should update subadmin" do
    put :update, id: @subadmin, subadmin: {  }
    assert_redirected_to subadmin_path(assigns(:subadmin))
  end

  test "should destroy subadmin" do
    assert_difference('Subadmin.count', -1) do
      delete :destroy, id: @subadmin
    end

    assert_redirected_to subadmins_path
  end
end
