 class CommentsController < ApplicationController
  #skip_after_filter :add_google_analytics_code
  #before_filter :require_login
  layout "bookmarks"

  
  #This should be admin stuff
  #Take a look
  def index
    @commentable = find_commentable
    @comments = @commentable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end


  #This should be removed
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  #this should also be removed
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end


  #admin area/stuff
  #Or remove
  def edit
    @comment = Comment.find(params[:id])
  end


  def create
    @commentable = find_commentable #Fetches Articles model from the params
    @comment = @commentable.comments.build(params[:comment]) #Creates comments on the article model
    @comment.user_id = current_user.id
    
    #@comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to @commentable }
        format.js
      else
        format.html { redirect_to @commentable }
        format.js
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @commentable = find_commentable #Fetches Articles model from the params
    @comment = @commentable.comments.find(params[:id]) #Creates comments on the article model

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @commentable = find_commentable #Fetches Articles model from the params
    @comment = @commentable.comments.find(params[:id]) #Creates comments on the article model

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_commentable
    params.each do |name,value|
      if name=~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end 
  end
    
end