class SettingsController < ApplicationController
  layout "standard"
  
  def index
    @user = User.find_by_id(current_user.id)
  end
end
