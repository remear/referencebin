class BookmarkImportsController < ApplicationController
  layout "bookmarks"
  before_filter :login_required
  
  def index
    #@bookmark_imports = BookmarkImport.all
    @bookmark_imports = BookmarkImport.paginate :page => params[:page]
  end
  
  def show
    @bookmark_import = BookmarkImport.find(params[:id])
  end
  
  def new
    @bookmark_import = BookmarkImport.new
  end
  
  def import
  end
  
  def do_import
    file = params[:do_import][:file]
    
    rowcount = 0
    
    BookmarkImport.transaction do
      FasterCSV.parse(file, :row_sep => "\r") do |row|
        title, url = row
        BookmarkImport.create(:title => title, :url => url)
        rowcount += 1 
      end
    end
    flash[:notice] = "Successfully added #{rowcount} bookmarks" 
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
    flash[:notice] = "Successfully destroyed bookmark import."
    redirect_to bookmark_imports_url
  end
end
