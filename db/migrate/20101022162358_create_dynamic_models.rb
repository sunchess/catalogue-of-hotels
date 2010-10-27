class CreateDynamicModels < ActiveRecord::Migration
  def self.up
    create_table :dynamic_models do |t|
      t.string :title
    end
  end

  def self.down
    drop_table :dynamic_models
  end
end
