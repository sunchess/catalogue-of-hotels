class DynamicField < ActiveRecord::Base
  has_many :fields_dynamic_fields
  belongs_to :fieldship, :polymorphic => true

  attr_accessible :title
end
