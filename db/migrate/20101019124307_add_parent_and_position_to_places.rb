class AddParentAndPositionToPlaces < ActiveRecord::Migration
  def self.up
    #act_as_tree and act_as_list
    add_column(:places, :parent_id,  :integer)
    add_column(:places, :position,  :integer, :null => false)
  end

  def self.down
    remove_column :places, :parent_id
    remove_column :places, :position
  end
end
