class AddUniqueUrlIndexToBookmarks < ActiveRecord::Migration
  def self.up
    add_index :bookmarks, :url, :unique => true
  end

  def self.down
    remove_index :bookmarks, :url
  end
end
