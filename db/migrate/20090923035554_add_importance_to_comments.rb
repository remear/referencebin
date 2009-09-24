class AddImportanceToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :importance, :string
  end

  def self.down
    remove_column :comments, :importance
  end
end
