class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :body
      t.integer :user_id
      t.integer :bookmark_id
      t.integer :count
      t.timestamps
    end
  end
  
  def self.down
    drop_table :questions
  end
end
