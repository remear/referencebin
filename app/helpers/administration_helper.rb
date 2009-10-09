module AdministrationHelper
  def admin?
    current_user.admin
  end
end
