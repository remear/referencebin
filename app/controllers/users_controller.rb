class UsersController < ApplicationController
  layout 'standard'
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save && @user.deliver_verification_instructions!
      flash[:notice] = "Your account has been created. Check your email for an activation link."
      redirect_to root_url
    else
      render :action => 'new'
    end
    rescue ActiveRecord::StatementInvalid
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
