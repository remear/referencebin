require 'test_helper'
require 'performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class BrowsingTest < ActionController::PerformanceTest
  def test_homepage
    get root_url
  end
  
  def test_bookmarks
    get bookmarks_path
  end
  
  def test_bookmark_langage_view
    get bookmark_category_path(bookmarks(:one).language.permalink)
  end
end
