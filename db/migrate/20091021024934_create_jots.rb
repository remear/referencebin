class CreateJots < ActiveRecord::Migration
  def self.up
    create_table :jots do |t|
      t.integer           :user_id
      t.integer           :language_id
      t.boolean           :private, :default => 0
      t.text              :code
      t.text              :error
      t.timestamps
    end
  end

  def self.down
    drop_table :jots
  end
end
