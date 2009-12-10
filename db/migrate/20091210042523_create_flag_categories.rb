class CreateFlagCategories < ActiveRecord::Migration
  def self.up
    create_table :flag_categories do |t|
      t.string :description
      t.string :priority

      t.timestamps
    end
  end

  def self.down
    drop_table :flag_categories
  end
end
