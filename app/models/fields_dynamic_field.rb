# == Schema Information
# Schema version: 20101115183243
#
# Table name: fields_dynamic_fields
#
#  id               :integer         not null, primary key
#  dynamic_field_id :integer
#  dynamic_id       :integer
#  dynamic_type     :string(255)
#

class FieldsDynamicField < ActiveRecord::Base
  belongs_to :dynamic_field
  belongs_to :dynamic, :polymorphic => true
  attr_accessible :dynamic_field_id, :dynamic_id, :dynamic_type
end
