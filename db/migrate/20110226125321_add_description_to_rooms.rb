class AddDescriptionToRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :description, :text
  end

  def self.down
    remove_column :rooms, :description
  end
end
