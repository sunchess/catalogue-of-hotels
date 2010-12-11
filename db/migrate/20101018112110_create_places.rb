class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :models do |t|
      t.string :title
      t.boolean :draft, :null=>false, :default=>true

      t.timestamps
    end
  end

  def self.down
    drop_table :models
  end
end
