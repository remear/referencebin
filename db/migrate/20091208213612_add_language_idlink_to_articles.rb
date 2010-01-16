class AddLanguageIdlinkToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :language_id, :integer
  end

  def self.down
    remove_column :articles, :language_id
  end
end
