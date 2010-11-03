class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.float :lat
      t.float :lng
      t.integer :zoom
      t.integer :mapable_id
      t.string :mapable_type

      t.timestamps
    end
    add_index(:maps, :mapable_id)
    add_index(:maps, :mapable_type)
  end

  def self.down
    drop_table :maps
  end
end
