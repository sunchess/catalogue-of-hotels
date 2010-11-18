class AddCaheImagesInPlace < ActiveRecord::Migration
  def self.up
    add_column(:places, :images_count, :integer, :default => 0, :null=>false)
  end

  def self.down
    remove_column(:places, :images_count)
  end
end
