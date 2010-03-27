require 'test_helper'

class PartnersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partner" do
    assert_difference('Partner.count') do
      post :create, :partner => { }
    end

    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should show partner" do
    get :show, :id => partners(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => partners(:one).to_param
    assert_response :success
  end

  test "should update partner" do
    put :update, :id => partners(:one).to_param, :partner => { }
    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should destroy partner" do
    assert_difference('Partner.count', -1) do
      delete :destroy, :id => partners(:one).to_param
    end

    assert_redirected_to partners_path
  end
end
