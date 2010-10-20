class CreateDynamicFields < ActiveRecord::Migration
  def self.up
    create_table :dynamic_fields do |t|
      t.string :title
      t.string :permalink
      t.integer :fieldship_id
      t.string :fieldship_type
    end
    
    add_index(:dynamic_fields, :fieldship_id)
    add_index(:dynamic_fields, :fieldship_type)
  end

  def self.down
    drop_table :dynamic_fields
  end
end
