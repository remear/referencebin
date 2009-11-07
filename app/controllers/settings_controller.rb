class SettingsController < ApplicationController
  before_filter :login_required
  skip_after_filter :add_google_analytics_code
  layout "standard"
  
  def index
    @user = User.find_by_id(current_user.id)
  end
end
