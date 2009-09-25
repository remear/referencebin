class AddLanguageIdToCode < ActiveRecord::Migration
  def self.up
    add_column :codes, :language_id, :integer
  end

  def self.down
    remove_column :codes, :language_id
  end
end
