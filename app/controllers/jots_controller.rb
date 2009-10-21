class JotsController < ApplicationController
  layout "standard"
  def index
    @jots = Jot.paginate_by_user_id current_user.id, :page => params[:page]
  end
  
  def show
    @jot = Jot.find(params[:id])
  end
  
  def new
    @jot = Jot.new
  end
  
  def create
    @jot = Jot.new(params[:jot])
    @jot.user_id = current_user.id
    
    if @jot.save
      flash[:notice] = "Successfully created jot."
      redirect_to @jot
    else
      render :action => 'new'
    end
  end
  
  def edit
    @jot = Jot.find(params[:id])
  end
  
  def update
    @jot = Jot.find(params[:id])
    if @jot.update_attributes(params[:jot])
      flash[:notice] = "Successfully updated jot."
      redirect_to @jot
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @jot = Jot.find(params[:id])
    @jot.destroy
    flash[:notice] = "Successfully destroyed jot."
    redirect_to jots_url
  end
end
