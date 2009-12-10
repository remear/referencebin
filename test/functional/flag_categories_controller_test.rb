require 'test_helper'

class FlagCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flag_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flag_category" do
    assert_difference('FlagCategory.count') do
      post :create, :flag_category => { }
    end

    assert_redirected_to flag_category_path(assigns(:flag_category))
  end

  test "should show flag_category" do
    get :show, :id => flag_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => flag_categories(:one).to_param
    assert_response :success
  end

  test "should update flag_category" do
    put :update, :id => flag_categories(:one).to_param, :flag_category => { }
    assert_redirected_to flag_category_path(assigns(:flag_category))
  end

  test "should destroy flag_category" do
    assert_difference('FlagCategory.count', -1) do
      delete :destroy, :id => flag_categories(:one).to_param
    end

    assert_redirected_to flag_categories_path
  end
end
