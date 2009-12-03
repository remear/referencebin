require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(users(:ben))
  end
  
  context "on GET to :new" do
    setup do
      get :new
    end
    
    should_respond_with :success
    should "assert user not nil" do
      assert_not_nil assigns(:user)
    end
    should_render_template :new
    should_render_with_layout "standard"
  end
  
  context "on GET to :edit" do
    setup do
      get :edit, :id => users(:ben).to_param
    end
    
    should_respond_with :success
    should_render_template :edit
    should_render_with_layout "standard"
    
    should "assert current_user is ben" do
      assert_equal(@user, assigns(:ben))
    end
  end

=begin
  should_be_restful do |resource|
    resource.parent = :user

    resource.create.params = { :firstname => 'new', :lastname => 'user', :nickname => 'newuser', :login => 'newuser',
       :email => 'newuser@demo.com' , :password => 'letmein', :password_confirmation => 'letmein'}
    resource.update.params = { :password => 'demo', :password_confirmation => 'demo' }
  end
=end
  
=begin

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should get edit" do
    get :edit, :id => users(:one).to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => users(:one).to_param, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end
=end
end
