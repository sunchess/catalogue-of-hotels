class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.integer :offer_agent_id
      t.string :name
      t.text :body
      t.float :price, :null=>false
      t.integer :fee, :null=>false
      t.integer :discount
      t.integer :images_count
      t.integer :position
      t.boolean :ad, :default => false, :null => false
      t.timestamps
    end
    add_index :offers, :price
    add_index :offers, :offer_agent_id
  end

  def self.down
    drop_table :offers
  end
end
