class FieldsDynamicField < ActiveRecord::Base
  belongs_to :dynamic_field
  belongs_to :dynamic, :polymorphic => true
end
