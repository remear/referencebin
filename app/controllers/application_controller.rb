# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  filter_parameter_logging :password

  helper_method :current_user

  def require_user
    if ! current_user
      flash[:notice] = "Please login"
      redirect_to login_path
    end
  end

  def access_denied
    redirect_to login_path
  end
  
  def require_login
    current_user || access_denied
  end
  
  def admin_required
    current_user.admin?
  end
  
  def url_lookup(url)
    @valid_responses = ["200", "301"]
    
	  @curl = %x{ curl -s --connect-timeout 3 -I #{url} --user-agent "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_1; en-us) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9" | grep HTTP }
	  
    if @valid_responses.include?(@curl[/\d\d\d/])
      return true
    else
      return false
    end
	end
	
  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
