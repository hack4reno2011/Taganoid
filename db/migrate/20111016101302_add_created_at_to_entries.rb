class AddCreatedAtToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :created_at, :timestamp
  end
end
