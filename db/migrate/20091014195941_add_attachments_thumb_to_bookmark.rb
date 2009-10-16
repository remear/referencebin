class AddAttachmentsThumbToBookmark < ActiveRecord::Migration
  def self.up
    add_column :bookmarks, :thumb_file_name, :string
    add_column :bookmarks, :thumb_content_type, :string
    add_column :bookmarks, :thumb_file_size, :integer
    add_column :bookmarks, :thumb_updated_at, :datetime
  end

  def self.down
    remove_column :bookmarks, :thumb_file_name
    remove_column :bookmarks, :thumb_content_type
    remove_column :bookmarks, :thumb_file_size
    remove_column :bookmarks, :thumb_updated_at
  end
end
