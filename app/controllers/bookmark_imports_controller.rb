class BookmarkImportsController < ApplicationController
  layout "bookmarks"
  before_filter :login_required
  
  def index
    #@bookmark_imports = BookmarkImport.all
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
    if @bookmark_import.tag_list.empty?
      @errors << 'Tag list cannot be empty'
    end
    if @bookmark_import.description.blank?
      @errors << 'Bookmark description cannot be empty'
    end
    
    @curl = %x{ curl -I #{@bookmark_import.url} --user-agent \"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_1; en-us) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9\" | grep HTTP }
    @curl = @curl[/\d\d\d/]
  end
  
  def new
    @bookmark_import = BookmarkImport.new
  end
  
  def import
  end
  
  def do_import
    file = params[:do_import][:file]
    
    rowcount = 0
    importcount = 0
    
    BookmarkImport.transaction do
      FasterCSV.parse(file, :row_sep => "\r") do |row|
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
    flash[:notice] = "Imported #{importcount} of #{rowcount} bookmarks" 
    redirect_to bookmark_imports_path
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
