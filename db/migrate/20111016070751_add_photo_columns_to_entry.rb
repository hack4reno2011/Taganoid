class AddPhotoColumnsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :photo_file_name,    :string
    add_column :entries, :photo_content_type, :string
    add_column :entries, :photo_file_size,    :string
    add_column :entries, :photo_updated_at,   :datetime
  end
end
