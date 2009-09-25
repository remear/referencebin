class AddLanguageIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :language_id, :integer
  end

  def self.down
    remove_column :comments, :language_id
  end
end
