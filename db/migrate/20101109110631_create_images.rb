class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|

      t.string  :image_file_name
      t.string  :image_content_type
      t.integer :image_file_size
      t.string  :imageable_type
      t.integer :imageable_id
      t.boolean :draft, :default=>true, :null=>false
      t.timestamps
    end

    add_index(:images, [:imageable_id, :imageable_type])
  end

  def self.down
    drop_table :images
  end
end
