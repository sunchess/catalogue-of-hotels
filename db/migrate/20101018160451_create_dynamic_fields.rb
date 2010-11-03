class CreateDynamicFields < ActiveRecord::Migration
  def self.up
    create_table :dynamic_fields do |t|
      t.integer :dynamic_model_id
      t.string :title
      t.string :permalink
      t.integer :position
      t.boolean :draft, :default=>false

    end

    add_index(:dynamic_fields, :dynamic_model_id)
    add_index(:dynamic_fields, :permalink)
  end

  def self.down
    drop_table :dynamic_fields
  end
end
