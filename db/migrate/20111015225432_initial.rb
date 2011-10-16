class Initial < ActiveRecord::Migration
  def up
    
    create_table :entry_types do |t|
      t.string :name, :null => false
    end
    
    create_table :statuses do |t|
      t.string :name, :null => false
    end
    
    create_table :groups do |t|
      t.string :name, :null => false
    end
    
    create_table :entries do |t|
      t.integer :entry_type_id, :null => false
      t.integer :status_id, :null => false
      t.integer :group_id, :null => false
      t.string :title, :null => false
      t.text :descr
      t.text :image_url
      t.float :latitude
      t.float :longitude
      t.string :creator_name
      t.string :creator_number
    end
    add_index :entries, :entry_type_id
    add_index :entries, :status_id
    add_index :entries, :group_id
    add_index :entries, :latitude
    add_index :entries, :longitude
    add_index :entries, :creator_name
    add_index :entries, :creator_number
    
  end

  def down
  end
end
