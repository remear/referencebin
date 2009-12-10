class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.column :flaggable_id,           :integer, :null => false
      t.column :flag_category_id,       :integer, :null => false
      t.column :flaggable_type,         :string,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :flags
  end
end
