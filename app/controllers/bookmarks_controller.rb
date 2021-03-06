class BookmarksController < ApplicationController
  layout "bookmarks"
  before_filter :require_login, :only => [ 'new', 'edit', 'create', 'update', 'destroy' ]
  skip_after_filter :add_google_analytics_code, :only => [ 'destroy', 'update' ]
  
  def index
    if params[:language]
      @bookmarks = Bookmark.paginate :page => params[:page], :limit => 30, :order => "created_at DESC",
                      :joins => :language, :conditions => {:languages => {:permalink => params[:language]} }
    else
      #@bookmarks = Bookmark.paginate :page => params[:page], :limit => 30, :order => "created_at DESC",
      #  :joins => "left outer join flags on flags.flaggable_id = bookmarks.id", :conditions => "flags.flaggable_id is null"
      @bookmarks = Bookmark.paginate :page => params[:page], :order => "created_at DESC", :joins => "left outer join flags on flags.flaggable_id = bookmarks.id", 
        :group => "bookmarks.id", :having => "count(flags.flaggable_id) < #{flag_tolerance}"
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
    @bookmark = Bookmark.find_by_id(params[:id])
    
    @url_status = url_lookup(@bookmark.url)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  def tag_cloud
    @tags = Bookmark.tag_counts
  end
  
  def post_question
    @bookmark = Bookmark.find(params[:id])
    
    @bookmark.question_list.add(params[:question])
    
    if @bookmark.save
      render :text => true
    else
      render :text => false
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
    
    @bookmark.user_id = current_user.id
    
    respond_to do |format|
      if @bookmark.save
        flash[:notice] = 'Bookmark was successfully created.'
        format.html { redirect_to bookmark_path(@bookmark.language.permalink, @bookmark) }
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
        format.html { bookmark_path(@bookmark.language.permalink, @bookmark) }
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
