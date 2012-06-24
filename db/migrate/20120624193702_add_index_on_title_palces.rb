class AddIndexOnTitlePalces < ActiveRecord::Migration
  def self.up
    add_index :places, :title
  end

  def self.down
    remove_index :places, :title
  end
end
