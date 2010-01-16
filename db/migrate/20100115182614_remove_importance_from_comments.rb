class RemoveImportanceFromComments < ActiveRecord::Migration
  def self.up
      remove_column :comments, :importance
  end

  def self.down
      add_column :comments, :importance, :string
  end
end
