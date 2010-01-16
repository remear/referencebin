class RemoveAuthorFromComments < ActiveRecord::Migration
  def self.up
    remove_column :comments, :author
  end

  def self.down
    add_column :comments, :author, :string
  end
end
