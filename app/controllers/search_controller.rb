class SearchController < ApplicationController
  layout 'standard', :except => 'index'
  
  def query
    if params[:query]
      if params[:query].include? "comments:"
        @params = params[:query].split(':')
        @type = @params[0]
        @query = @params[1]
        @results = Comment.search @query, :star => true, :page => params[:page], :per_page => 20
      elsif params[:query].include? "tags:"
        @results = ThinkingSphinx.search params[:query], :page => params[:page], :per_page => 20
      else
        @results = Bookmark.search params[:query], :page => params[:page], :per_page => 20
      end
    end
    
    render :template => 'search/results'
  end
  
  def index
    @bookmarks = Bookmark.find(:all, :limit => 12, :order => 'created_at DESC')
    #@results = ThinkingSphinx.search params[:query]
    render :layout => 'front'
  end
end
