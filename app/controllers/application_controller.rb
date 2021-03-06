# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  filter_parameter_logging :password

  helper_method :current_user
  helper_method :flag_tolerance
  
  before_filter :mailer_set_url_options
  
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def require_user
    if ! current_user
      access_denied
      flash[:error] = "Please login"
    end
  end

  def access_denied
    store_location
    redirect_to login_path
  end
  
  def require_login
    current_user || access_denied
  end
  
  def require_admin
    current_user.admin?
  end

  # Store the URI of the current request in the session.
  # We can return to this location by calling #redirect_back_or_default.
  def store_location
    session[:return_to] = request.referrer
  end

  # Redirect to the URI stored by the most recent store_location call or
  # to the passed default.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
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
  
  def flag_tolerance
    3
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
