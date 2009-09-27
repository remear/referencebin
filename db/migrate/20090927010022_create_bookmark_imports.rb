class CreateBookmarkImports < ActiveRecord::Migration
  def self.up
    create_table :bookmark_imports do |t|
      t.string :title
      t.string :url
      t.integer :user_id
      t.string :description
      t.integer :language_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :bookmark_imports
  end
end
