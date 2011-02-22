class AddArticlesCountToPlace < ActiveRecord::Migration
  def self.up
    add_column :places, :articles_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :places, :articles_count
  end
end
