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
