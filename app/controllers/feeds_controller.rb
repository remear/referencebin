class FeedsController < ApplicationController
  def rubyonrails
    @bookmarks = Bookmark.find(:all, :limit => 10, :order => "created_at DESC")
  end
end
