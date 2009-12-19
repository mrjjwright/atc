require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workout" do
    assert_difference('Workout.count') do
      post :create, :workout => { }
    end

    assert_redirected_to workout_path(assigns(:workout))
  end

  test "should show workout" do
    get :show, :id => workouts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => workouts(:one).to_param
    assert_response :success
  end

  test "should update workout" do
    put :update, :id => workouts(:one).to_param, :workout => { }
    assert_redirected_to workout_path(assigns(:workout))
  end

  test "should destroy workout" do
    assert_difference('Workout.count', -1) do
      delete :destroy, :id => workouts(:one).to_param
    end

    assert_redirected_to workouts_path
  end
end
