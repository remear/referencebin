require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  #setup :activate_authlogic # run before tests are executed
  #UserSession.create(users(:ben)) # logs a user in
 
  context "on GET to :index" do
    setup do
      get :index
    end
    
    should_assign_to :bookmarks
    should_respond_with :success
    should_render_template :index
  end

=begin  
  context "on GET to :show for first record" do
    setup do
      get :show, :language => 1, :id => 1
    end

    should_assign_to :user
    should_respond_with :success
    should_render_template :show
    #should_not_set_the_flash

    #should "do something else really cool" do
    #  assert_equal 1, assigns(:user).id
    #end
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
=end
end