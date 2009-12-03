class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name
      t.string :permalink
      t.timestamps
    end
    add_index :languages, :name, :unique => true
  end

  def self.down
    drop_table :languages
  end
end
