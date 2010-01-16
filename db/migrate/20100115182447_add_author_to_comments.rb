class AddAuthorToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :author, :string
  end

  def self.down
    remove_column :comments, :author
  end
end
