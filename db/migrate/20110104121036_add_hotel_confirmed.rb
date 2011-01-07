class AddHotelConfirmed < ActiveRecord::Migration
  def self.up
    add_column :hotels, :confirmed, :boolean, :null=>false, :default=>false
  end

  def self.down
    remove_column :hotels, :confirmed
  end
end
