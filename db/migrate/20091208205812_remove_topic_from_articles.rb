class RemoveTopicFromArticles < ActiveRecord::Migration
  def self.up
    remove_column :articles, :topic
  end

  def self.down
    add_column :articles, :topic, :string
  end
end
