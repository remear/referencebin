require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  def setup
    login_user
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmark" do
    assert_difference('Bookmark.count') do
      post :create, :bookmark => { :title => 'Test Bookmark', :description => 'This is a test description',
        :url => 'http://edge.referencebin.com', :language_id => 1, :user_id => 1 }
    end

    assert_redirected_to bookmark_path(assigns(:bookmark).language.permalink, assigns(:bookmark).permalink)
  end

  test "should show bookmark" do
    get :show, :bookmark_name => bookmarks(:one).permalink
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bookmarks(:one).to_param
    assert_response :success
  end

  test "should update bookmark" do
    put :update, :id => bookmarks(:one).to_param, :bookmark => { :description => 'Changed description' }
    assert_redirected_to bookmark_path(assigns(:bookmark).language.permalink, assigns(:bookmark).permalink)
  end

  test "should destroy bookmark" do
    assert_difference('Bookmark.count', -1) do
      delete :destroy, :id => bookmarks(:one).to_param
    end

    assert_redirected_to bookmarks_path
  end
end