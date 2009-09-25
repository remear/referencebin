class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.integer :user_id
      t.integer :user_id
      t.string :title
      t.text :body
      
      t.timestamps
    end
  end

  def self.down
    drop_table :codes
  end
end