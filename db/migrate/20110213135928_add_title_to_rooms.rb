class AddTitleToRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :title, :string
  end

  def self.down
    remove_column :rooms, :title
  end
end
