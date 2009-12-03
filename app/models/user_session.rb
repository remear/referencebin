class UserSession < Authlogic::Session::Base
  validate :check_if_verified
  
  private
    def check_if_verified
      errors.add(:base, "Not yet verified") unless attempted_record && attempted_record.active
    end
end