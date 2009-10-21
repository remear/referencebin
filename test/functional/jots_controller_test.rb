require 'test_helper'

class JotsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jot.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jot.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jot.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to jot_url(assigns(:jot))
  end
  
  def test_edit
    get :edit, :id => Jot.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jot.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jot.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jot.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jot.first
    assert_redirected_to jot_url(assigns(:jot))
  end
  
  def test_destroy
    jot = Jot.first
    delete :destroy, :id => jot
    assert_redirected_to jots_url
    assert !Jot.exists?(jot.id)
  end
end
