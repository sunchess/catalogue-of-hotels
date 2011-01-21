class CreateReserves < ActiveRecord::Migration
  def self.up
    create_table :reserves do |t|
      t.integer :room_id
      t.integer :user_id
      t.integer :status, :null=>false, :default=>0
      t.string  :name     
      t.string  :address
      t.string  :telephone
      t.text    :list_tourists
      t.date    :coming_on
      t.date    :outing_on
      t.float   :coast, :null=>false, :default=>0
      t.integer :discount, :null=>false, :default=>0
      t.string  :description #пожелания
      t.timestamps
    end
    add_index :reserves, :room_id
    add_index :reserves, :user_id
  end

  def self.down
    drop_table :reserves
  end
end
