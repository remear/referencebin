class AdministrationController < ApplicationController
  before_filter :require_login
  before_filter :admin_required
  skip_after_filter :add_google_analytics_code
  
  layout "administration"
  
  def index
    @bookmarks = Bookmark.count(:all)
    @bookmarkimports = BookmarkImport.count(:all)
  end
  
  def databases
    @tables = ActiveRecord::Base.connection.execute("show table status 'bookmarks';")
  end
end
