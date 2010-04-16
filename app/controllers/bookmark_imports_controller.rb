class BookmarkImportsController < ApplicationController
  layout "bookmarks"
  
  before_filter :require_login
  skip_after_filter :add_google_analytics_code
  
  def index
    @bookmark_imports = BookmarkImport.paginate_by_user_id current_user.id, :page => params[:page]
  end
  
  def show
    @bookmark_import = BookmarkImport.find(params[:id])
    @errors = Array.new
    if @bookmark_import.title.blank?
      @errors << 'Bookmark title cannot be empty'
    end
    if @bookmark_import.url.blank?
      @errors << 'Bookmark url cannot be empty'
    end
    if @bookmark_import.language_id.blank?
      @errors << 'A language must be specified'
    end
    if @bookmark_import.topic_list.empty?
      @errors << 'Topic list cannot be empty'
    end
    if @bookmark_import.description.blank?
      @errors << 'Bookmark description cannot be empty'
    end
    
    @url_status = url_lookup(@bookmark_import.url)
  end
  
  def new
    @bookmark_import = BookmarkImport.new
  end
  
  def import
  end
  
  def add_question
    #@bookmark = Bookmark.find_by_id
  end
  
  def convert
    @bookmark_import = BookmarkImport.find(params[:id])
    @bookmark = Bookmark.new(@bookmark_import.attributes)
    
    if @bookmark.save
      @bookmark_import.destroy
      flash[:notice] = 'Bookmark was successfully made live.'
      redirect_to bookmark_path(:lang => @bookmark.language.permalink, :bookmark_name => @bookmark.permalink)
    else
      flash[:warning] = 'An error occured while trying to make the bookmark live.'
      redirect_to :back
    end
  end
  
  def convert_all
    @bookmark_imports = BookmarkImport.find(:all, :conditions => "description IS NOT NULL and title IS NOT NULL and language_id IS NOT NULL and url IS NOT NULL")
    
    importcount = 0
    
    Bookmark.transaction do
      @bookmark_imports.each do |bookmarkimport|
        logger.debug("BOOKMARK TO IMPORT : #{bookmarkimport.title}")
        @bookmark = Bookmark.new(bookmarkimport.attributes)
        if @bookmark.save
          bookmarkimport.destroy
          importcount += 1
          flash[:notice] = "Made #{importcount} bookmarks live"
        else
           logger.debug("///////////// COULDN'T SAVE BOOKMARK")
           @bookmark.errors.each do |error|
             logger.debug(error)
           end
           logger.debug("////////////")
          flash[:error] = "Unable to make some bookmarks live"
        end
      end
    end
    
    
    redirect_to bookmarks_path
  end
  
  def do_import
    require 'csv'
    begin 
      file = params[:do_import][:file]
      rowcount = 0
      importcount = 0

      BookmarkImport.transaction do
        CSV.parse(file, :row_sep => "\r") do |row|
          title, url = row
          @bookmark_pass = Bookmark.all(:conditions => ["BINARY bookmarks.url = ?", url])
          @bookmark_import_pass = BookmarkImport.all(:conditions => ["BINARY bookmark_imports.url = ?", url])
          if @pass.blank? && @bookmark_import_pass.blank?
            BookmarkImport.create(:title => title, :url => url, :user_id => current_user.id)
            importcount += 1
          end
          rowcount += 1
        end
      end
      rescue CSV::MalformedCSVError
        @error = "CSV::MalformedCSVError"
        render :file => "#{RAILS_ROOT}/public/error.html.erb"
      else
        flash[:notice] = "Imported #{importcount} of #{rowcount} bookmarks" 
        redirect_to bookmark_imports_path
    end
  end
  
  def create
    @bookmark_import = BookmarkImport.new(params[:bookmark_import])
    if @bookmark_import.save
      flash[:notice] = "Successfully created bookmark import."
      redirect_to @bookmark_import
    else
      render :action => 'new'
    end
  end
  
  def edit
    @bookmark_import = BookmarkImport.find(params[:id])
  end
  
  def update
    @bookmark_import = BookmarkImport.find(params[:id])
    if @bookmark_import.update_attributes(params[:bookmark_import])
      flash[:notice] = "Successfully updated bookmark import."
      redirect_to @bookmark_import
    else
      render :action => 'edit'
    end
  end
  
  def destroy_all
    @bookmark_imports = BookmarkImport.find_all_by_user_id(current_user.id)
    @bookmark_imports.each do |bookmark|
      bookmark.destroy
    end
    flash[:notice] = "Removed all imported bookmarks."
    redirect_to bookmark_imports_url
  end
  
  def destroy
    @bookmark_import = BookmarkImport.find(params[:id])
    @bookmark_import.destroy
    
    respond_to do |format|
      format.html do
        flash[:notice] = "Successfully destroyed bookmark import."
        redirect_to bookmark_imports_url
      end
      format.js
    end
  end
end
