require 'test_helper'

class AboutsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create about" do
    assert_difference('About.count') do
      post :create, :about => { }
    end

    assert_redirected_to about_path(assigns(:about))
  end

  test "should show about" do
    get :show, :id => abouts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => abouts(:one).to_param
    assert_response :success
  end

  test "should update about" do
    put :update, :id => abouts(:one).to_param, :about => { }
    assert_redirected_to about_path(assigns(:about))
  end

  test "should destroy about" do
    assert_difference('About.count', -1) do
      delete :destroy, :id => abouts(:one).to_param
    end

    assert_redirected_to abouts_path
  end
end
