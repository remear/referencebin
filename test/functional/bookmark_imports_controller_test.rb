=begin
require 'test_helper'

class BookmarkImportsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => BookmarkImport.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    BookmarkImport.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    BookmarkImport.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to bookmark_import_url(assigns(:bookmark_import))
  end
  
  def test_edit
    get :edit, :id => BookmarkImport.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    BookmarkImport.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BookmarkImport.first
    assert_template 'edit'
  end
  
  def test_update_valid
    BookmarkImport.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BookmarkImport.first
    assert_redirected_to bookmark_import_url(assigns(:bookmark_import))
  end
  
  def test_destroy
    bookmark_import = BookmarkImport.first
    delete :destroy, :id => bookmark_import
    assert_redirected_to bookmark_imports_url
    assert !BookmarkImport.exists?(bookmark_import.id)
  end
end
=end