# == Schema Information
# Schema version: 20101022162358
#
# Table name: places
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  draft      :boolean
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#  position   :integer         not null
#

class Place < ActiveRecord::Base
  belongs_to :region
  has_many :dfields, :as=>:relationship, :class_name=>"DynamicField"
  has_many :fields_dynamic_fields, :as=>:dynamic
  has_many :dynamic_fields, :through=>:fields_dynamic_fields
  
  attr_accessible :title, :draft
  
end
