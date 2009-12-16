require 'test_helper'

class MediaProfilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create media_profile" do
    assert_difference('MediaProfile.count') do
      post :create, :media_profile => { }
    end

    assert_redirected_to media_profile_path(assigns(:media_profile))
  end

  test "should show media_profile" do
    get :show, :id => media_profiles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => media_profiles(:one).to_param
    assert_response :success
  end

  test "should update media_profile" do
    put :update, :id => media_profiles(:one).to_param, :media_profile => { }
    assert_redirected_to media_profile_path(assigns(:media_profile))
  end

  test "should destroy media_profile" do
    assert_difference('MediaProfile.count', -1) do
      delete :destroy, :id => media_profiles(:one).to_param
    end

    assert_redirected_to media_profiles_path
  end
end
