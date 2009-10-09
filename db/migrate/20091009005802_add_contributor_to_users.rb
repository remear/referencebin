class AddContributorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :contributor, :boolean, :default => 0
  end

  def self.down
    remove_column :users, :contributor
  end
end
