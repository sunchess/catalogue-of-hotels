class AddPolymorphToReserves < ActiveRecord::Migration
  def self.up
    remove_column :reserves, :room_id
    add_column :reserves, :orderable_id, :integer
    add_column :reserves, :orderable_type, :string
    add_column :reserves, :all_tourists, :integer
    add_index :reserves, :orderable_id
    add_index :reserves, :orderable_type
  end

  def self.down
    remove_index :reserves, :column => :orderable_type
    remove_index :reserves, :column => :orderable_id
    remove_column :reserves, :all_tourists
    remove_column :reserves, :orderable_type
    remove_column :reserves, :orderable_id
    add_column :reserves, :room_id
  end
end
