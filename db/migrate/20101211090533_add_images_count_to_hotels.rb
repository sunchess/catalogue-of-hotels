class AddImagesCountToHotels < ActiveRecord::Migration
  def self.up
    add_column :hotels, :images_count, :integer, :default=>0, :null=>false
  end

  def self.down
    remove_column :hotels, :images_count
  end
end
