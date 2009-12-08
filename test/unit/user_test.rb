# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  login               :string(255)     not null
#  email               :string(255)     not null
#  firstname           :string(255)     not null
#  lastname            :string(255)     not null
#  nickname            :string(255)     not null
#  admin               :boolean(1)
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  landing_page        :integer(4)      default(0)
#  active              :boolean(1)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_have_class_methods :new, :create, :update#, :edit
  
  #should_validate_presence_of :login
  #should_not_allow_values_for :phone_number, "abcd", "1234"
  #should_allow_values_for :phone_number, "(123) 456-7890"
  should_validate_uniqueness_of :login, :email
  #should_not_allow_mass_assignment_of :crypted_password

  should_have_many :bookmarks, :bookmark_imports, :jots
  should_have_many :comments, :through => :bookmarks
end
