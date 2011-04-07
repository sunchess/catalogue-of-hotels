class AddFeeAndDiscountToRooms < ActiveRecord::Migration
  def self.up
    add_column :prices, :fee, :integer, :default => 20, :null => false
    add_column :prices, :discount, :integer, :default => 5, :null => false
  end

  def self.down
    remove_column :prices, :discount
    remove_column :prices, :fee
  end
end
