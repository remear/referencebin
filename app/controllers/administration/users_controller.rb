=begin
class Administration::UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout "administration", :except => ['register', 'create']
  
  include AuthenticatedSystem
  before_filter :require_login, :except => [ 'register', 'create', 'activate' ]
  before_filter :admin_required, :except => [ 'register', 'create', 'activate' ]
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
  
  def register
    @user = User.new
    render :layout => 'standard'
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      flash[:notice] = "Thanks for registering!  We're sending you an email with your activation code."
      redirect_to root_url
    else
      flash[:error] = "We couldn't set up that account, sorry.  Please try again, or contact an admin."
      #FIXME: fix redirect to not render /administration/users
      render :action => 'new', :layout => 'standard'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
      when (!params[:activation_code].blank?) && user && !user.active?
        user.activate!
        flash[:notice] = "Registration complete! You may now sign in with your account."
        redirect_to login_path
      when params[:activation_code].blank?
        flash[:error] = "The activation code was missing.  Please follow the URL from your email."
        redirect_to root_url
      else 
        flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
        redirect_to root_url
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
=end