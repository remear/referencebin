class ArticlesController < ApplicationController
  layout "standard"
  #before_filter :require_login

  def index
   if params[:language]
      @articles = Article.paginate :page => params[:page], :limit => 30, :order => "created_at DESC",
                      :joins => :language, :conditions => {:languages => {:permalink => params[:language]} }
    else
      @articles = Article.paginate :page => params[:page], :limit => 30, :order => "created_at DESC"
    end
    
    respond_to do |format|
      format.html # index.html.erb

    end
  end
  
  #Take a look
  def tags
    if params[:tag]
      @articles = article.paginate_tagged_with params[:tag], :page => params[:page]
    else
      @tags = Articles.tag_counts
    end
    
    respond_to do |format|
      format.html
    end
  end


  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def tag_cloud
    @tags = Articles.tag_counts
  end

  #Take a look 
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb

    end
  end
  
  #Take a look
  def create
      @article = Article.new(params[:article])
      @article.user_id = current_user.id  
      respond_to do |format|
        if @article.save
          flash[:notice] = 'Article was successfully created.'
          format.html { redirect_to Article_path(@article.language.permalink, @article) }
        else
          format.html { render :action => "new" }
        end
      end
  end
  
  #Take a look
  def edit
    @article = Article.find(params[:id])
  end

  #Take a look
  
  def create
    @article = Article.new(params[:article])
    @article.comments.build

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(@article) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  #take a look
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
       format.html { article_path(@article.language.permalink, @article) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  #Take a look
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
end
