class Place < ActiveRecord::Base
  belongs_to :region
  has_many :dfields, :as=>:fieldship, :class_name=>"DynamicField"
  has_many :fields_dynamic_fields, :as=>:dynamic
  has_many :dynamic_fields, :through=>:fields_dynamic_fields
  
  attr_accessible :title, :draft
  
end
