require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end




# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  body             :text
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  name             :string(255)
#  email            :string(255)
#

