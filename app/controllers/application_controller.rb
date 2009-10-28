# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def url_lookup(url)
    @valid_responses = ["200", "301"]
    
	  @curl = %x{ curl -s --connect-timeout 3 -I #{url} --user-agent "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_1; en-us) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9" | grep HTTP }
	  
    if @valid_responses.include?(@curl[/\d\d\d/])
      return true
    else
      return false
    end
	end	
end
