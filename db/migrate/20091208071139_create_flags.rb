class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.column :bookmark_id, :integer, :null => false
      t.column :reason,      :string,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :flags
  end
end
