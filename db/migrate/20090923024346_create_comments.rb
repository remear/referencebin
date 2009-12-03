class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :bookmark_id
      t.integer :language_id
      t.string  :title
      t.text    :body
      t.string  :importance

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
