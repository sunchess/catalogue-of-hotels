class CreateFieldsDynamicFields < ActiveRecord::Migration
  def self.up
    create_table :fields_dynamic_fields do |t|
      t.integer :dynamic_field_id
      t.integer :dynamic_id
      t.string :dynamic_type
    end
    
    add_index(:fields_dynamic_fields, :dynamic_field_id)
    add_index(:fields_dynamic_fields, :dynamic_id)
    add_index(:fields_dynamic_fields, :dynamic_type)
  end

  def self.down
    drop_table :fields_dynamic_fields
  end
end
