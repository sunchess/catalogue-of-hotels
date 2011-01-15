class CreateReserves < ActiveRecord::Migration
  def self.up
    create_table :reserves do |t|
      t.integer :room_id
      t.integer :user_id
      t.integer :status
      t.string  :name     
      t.string  :address
      t.string  :telephon
      t.text    :list_turists
      t.date    :coming
      t.date    :outing
      t.timestamps
    end
    add_index :reserves, :room_id
    add_index :reserves, :user_id
  end

  def self.down
    drop_table :reserves
  end
end
