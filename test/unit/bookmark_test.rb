# == Schema Information
#
# Table name: bookmarks
#
#  id                 :integer(4)      not null, primary key
#  title              :string(255)
#  url                :string(255)
#  description        :string(255)
#  permalink          :string(255)
#  user_id            :integer(4)
#  language_id        :integer(4)
#  thumb_file_name    :string(255)
#  thumb_content_type :string(255)
#  thumb_file_size    :string(255)
#  thumb_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
