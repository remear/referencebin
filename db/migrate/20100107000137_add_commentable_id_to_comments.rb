class AddCommentableIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :commentable_id, :integer
  end

  def self.down
    remove_column :comments, :commentable_id
  end
end
