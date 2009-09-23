class AddBookmarkIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :bookmark_id, :int
  end

  def self.down
    remove_column :comments, :bookmark_id
  end
end
