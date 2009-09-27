require 'test_helper'

class BookmarkImportTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert BookmarkImport.new.valid?
  end
end
