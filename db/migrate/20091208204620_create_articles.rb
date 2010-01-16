class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :topic
      t.text :content
      t.text :content_html
      t.references :user
      t.boolean :published
      t.boolean :commentable

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
