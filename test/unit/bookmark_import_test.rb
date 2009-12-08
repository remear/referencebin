# == Schema Information
#
# Table name: bookmark_imports
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  url         :string(255)
#  user_id     :integer(4)
#  description :string(255)
#  language_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

=begin
require 'test_helper'

class BookmarkImportTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert BookmarkImport.new.valid?
  end
end
=end
