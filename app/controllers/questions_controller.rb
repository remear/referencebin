class QuestionsController < ApplicationController
  before_filter :login_required
  skip_after_filter :add_google_analytics_code
  layout "standard"
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(params[:question])
    @question.user_id = current_user.id
    @question.bookmark_id = params[:bookmark_id]
    @question.save
    render :template => false
=begin
    if @question.save
      flash[:notice] = "Successfully created question."
      redirect_to @question
    else
      render :action => 'new'
    end
=end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Successfully updated question."
      redirect_to @question
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Successfully destroyed question."
    redirect_to questions_url
  end
end
