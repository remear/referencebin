class BookmarksController < ApplicationController
  layout "bookmarks"
  before_filter :login_required, :only => [ 'new', 'edit', 'create', 'update', 'destroy' ]
  
  def index
    if params[:lang]
      @lang = Language.find_by_permalink(params[:lang])
      @bookmarks = Bookmark.paginate_by_language_id @lang.id, :page => params[:page]
    else
      @bookmarks = Bookmark.paginate :page => params[:page], :limit => 30, :order => "created_at DESC"
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @bookmarks }
    end
  end
  
  def tags
    if params[:tag]
      @bookmarks = Bookmark.paginate_tagged_with params[:tag], :page => params[:page]
    else
      @tags = Bookmark.tag_counts
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @bookmarks }
    end
  end

  def show
    lang = Language.find_by_permalink(params[:lang])
    @bookmark = Bookmark.find_by_permalink(params[:bookmark_name], :conditions => {:language_id => lang.id}, :include => "comments")
    
    @url_status = url_lookup(@bookmark.url)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  def tag_cloud
    @tags = Bookmark.tag_counts
  end
      
  def dec_content_length
    session[:bookmark_content_length] -= 1
    
    #if params[:lang]
      #@lang = Language.find_by_permalink(params[:lang])
      @bookmarks = Bookmark.paginate :conditions => ["language_id = #{@lang.id}"], :per_page => per_page(60), :page => params[:page]
    #else
    #  @bookmarks = Bookmark.paginate :per_page => per_page(60), :page => params[:page]
    #end
    
    respond_to do |format|
      format.js { render :action => 'content_length.rjs' }
    end
  end
  
  def inc_content_length
    session[:bookmark_content_length] += 1
    
    if params[:lang]
      @lang = Language.find_by_permalink(params[:lang])
      @bookmarks = Bookmark.paginate :conditions => ["language_id = #{@lang.id}"], :per_page => per_page(60), :page => params[:page]
    else
      @bookmarks = Bookmark.paginate :per_page => per_page(60), :page => params[:page]
    end
    
    respond_to do |format|
      format.js { render :action => 'content_length.rjs' }
    end
  end
  
  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        flash[:notice] = 'Bookmark was successfully created.'
        format.html { redirect_to bookmark_path(:lang => @bookmark.language.permalink, :bookmark_name => @bookmark.permalink) }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        flash[:notice] = 'Bookmark was successfully updated.'
        format.html { redirect_to bookmark_path(:lang => @bookmark.language.permalink, :bookmark_name => @bookmark.permalink) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to(bookmarks_url) }
      format.xml  { head :ok }
    end
  end
end
