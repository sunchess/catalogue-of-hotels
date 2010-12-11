class CreateHotels < ActiveRecord::Migration
  def self.up
    create_table :hotels do |t|
      t.integer :place_id
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :street
      t.string :house_number
      t.text :telephone
      t.string :fax
      t.integer :distance #to sea
      t.boolean :draft, :null=>false, :default=>true
      t.boolean :paid_placement, :null=>false, :default=>false #for hotel wich not contract with us
      t.text :banking_details
      t.integer :images_count
      t.integer :rooms_count

      t.timestamps
    end

    add_index(:hotels, :place_id)
    add_index(:hotels, :user_id)
  end

  def self.down
    drop_table :hotels
  end
end
