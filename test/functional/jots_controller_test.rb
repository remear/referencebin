require 'test_helper'

class JotsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(users(:ben))
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jot" do
    assert_difference('Jot.count') do
      post :create, :jot => { :error => 'error', :code => 'def test\nputs "foo"\nend', :language_id => 1 }, :user_id => 1
    end

    assert_redirected_to jot_path(assigns(:jot))
  end

  test "should show jot" do
    get :show, :id => jots(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => jots(:one).to_param
    assert_response :success
  end

  test "should update jot" do
    put :update, :id => jots(:one).to_param, :jot => { :error => 'undefined method' }
    assert_redirected_to jot_path(assigns(:jot))
  end

  test "should destroy jot" do
    assert_difference('Jot.count', -1) do
      delete :destroy, :id => jots(:one).to_param
    end

    assert_redirected_to jots_path
  end
end