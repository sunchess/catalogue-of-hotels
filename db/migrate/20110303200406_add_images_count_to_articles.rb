class AddImagesCountToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :images_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :articles, :images_count
  end
end
