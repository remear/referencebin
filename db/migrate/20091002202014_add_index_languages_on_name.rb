class AddIndexLanguagesOnName < ActiveRecord::Migration
  def self.up
    add_index :languages, :name, :unique => true
  end

  def self.down
    remove_index :languages, :name
  end
end
