class UserSessionsController < ApplicationController
  skip_after_filter :add_google_analytics_code
  layout 'standard'

  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out"
    redirect_to root_url
  end

  def verify
    @user = User.find_using_perishable_token(params[:id])
    if @user
      if @user.verify!
        flash[:notice] = "Your account has been activated! You may now log in"
        redirect_to login_url
      else
        flash[:notice] = "Unable to find account"
      end
    else
      flash[:error] = "Unable to find account"
      redirect_to root_url
    end
  end
end
