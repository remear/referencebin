class AdministrationController < ApplicationController
  before_filter :login_required
  before_filter :admin_required
  layout "administration"
  
  def index
    @bookmarks = Bookmark.count(:all)
    @bookmarkimports = BookmarkImport.count(:all)
  end
end
