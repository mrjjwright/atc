require 'test_helper'

class TimeSlotsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_slots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_slot" do
    assert_difference('TimeSlot.count') do
      post :create, :time_slot => { }
    end

    assert_redirected_to time_slot_path(assigns(:time_slot))
  end

  test "should show time_slot" do
    get :show, :id => time_slots(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => time_slots(:one).to_param
    assert_response :success
  end

  test "should update time_slot" do
    put :update, :id => time_slots(:one).to_param, :time_slot => { }
    assert_redirected_to time_slot_path(assigns(:time_slot))
  end

  test "should destroy time_slot" do
    assert_difference('TimeSlot.count', -1) do
      delete :destroy, :id => time_slots(:one).to_param
    end

    assert_redirected_to time_slots_path
  end
end
