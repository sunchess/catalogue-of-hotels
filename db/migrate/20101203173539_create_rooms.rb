class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.integer :hotel_id
      t.integer :places
      t.integer :room_number
      t.integer :shower
      t.integer :toilet
      t.integer :fridge
      t.integer :tv
      t.integer :images_count

      t.timestamps
    end
    add_index :rooms, :hotel_id
  end

  def self.down
    drop_table :rooms
  end
end
