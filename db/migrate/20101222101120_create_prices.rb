class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.integer :room_id
      t.integer :month
      t.integer :cost

      t.timestamps
    end
     
    add_index :prices, :room_id
  end

  def self.down
    drop_table :prices
  end
end
