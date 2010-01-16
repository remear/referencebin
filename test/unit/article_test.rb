require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: articles
#
#  id           :integer(4)      not null, primary key
#  content      :text
#  content_html :text
#  user_id      :integer(4)
#  published    :boolean(1)
#  commentable  :boolean(1)
#  created_at   :datetime
#  updated_at   :datetime
#  title        :string(255)
#  permalink    :string(255)
#  language_id  :integer(4)
#

