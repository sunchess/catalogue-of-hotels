class AddIndexToReserves < ActiveRecord::Migration
  def self.up
    add_index :reserves, :status
  end

  def self.down
    remove_index :reserves, :column => :status
  end
end
