class AddAdToRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :ad, :boolean, :default => false
  end

  def self.down
    remove_column :rooms, :ad
  end
end
