# == Schema Information
# Schema version: 20101101133212
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
  acts_as_tree
  acts_as_list

  has_many :fields_dynamic_fields, :as=>:dynamic, :dependent => :destroy
  has_many :dynamic_fields, :through=>:fields_dynamic_fields
  has_one  :coordinate, :as=>:mapable, :class_name=>"Map"
  validates_uniqueness_of :title, :scope => :parent_id
  validates_presence_of :title

  attr_accessible :title, :parent_id, :draft, :position
  
end
