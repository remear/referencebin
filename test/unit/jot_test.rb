require 'test_helper'

class JotTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jot.new.valid?
  end
end
