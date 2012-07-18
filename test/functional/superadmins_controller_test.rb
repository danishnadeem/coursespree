require 'test_helper'

class SuperadminsControllerTest < ActionController::TestCase
  setup do
    @superadmin = superadmins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:superadmins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create superadmin" do
    assert_difference('Superadmin.count') do
      post :create, superadmin: { user_id: @superadmin.user_id }
    end

    assert_redirected_to superadmin_path(assigns(:superadmin))
  end

  test "should show superadmin" do
    get :show, id: @superadmin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @superadmin
    assert_response :success
  end

  test "should update superadmin" do
    put :update, id: @superadmin, superadmin: { user_id: @superadmin.user_id }
    assert_redirected_to superadmin_path(assigns(:superadmin))
  end

  test "should destroy superadmin" do
    assert_difference('Superadmin.count', -1) do
      delete :destroy, id: @superadmin
    end

    assert_redirected_to superadmins_path
  end
end
