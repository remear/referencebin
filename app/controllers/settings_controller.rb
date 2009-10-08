class SettingsController < ApplicationController
  skip_after_filter :add_google_analytics_code
  layout "standard"
  
  def index
    @user = User.find_by_id(current_user.id)
  end
end
