class RemoveModelIdFromComments < ActiveRecord::Migration
  def self.up
    remove_column :comments, :user_id
    remove_column :comments, :bookmark_id
    remove_column :comments, :language_id
  end

  def self.down
    add_column :comments, :language_id, :integer
    add_column :comments, :bookmark_id, :integer
    add_column :comments, :user_id, :integer
  end
end
