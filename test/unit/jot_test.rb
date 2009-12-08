# == Schema Information
#
# Table name: jots
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  language_id :integer(4)
#  private     :boolean(1)
#  code        :text
#  error       :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class JotTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
end
