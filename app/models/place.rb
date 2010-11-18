# == Schema Information
# Schema version: 20101115183243
#
# Table name: places
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  draft        :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  parent_id    :integer
#  position     :integer
#  images_count :integer         default(0), not null
#

class Place < ActiveRecord::Base
  acts_as_tree
  acts_as_list

  scope :public, where(:draft=>false, :parent_id=>nil).includes([ :children ])

  has_many :images, :as=>:imageable, :dependent => :destroy
  has_many :fields_dynamic_fields, :as=>:dynamic, :dependent => :destroy
  has_many :dynamic_fields, :through=>:fields_dynamic_fields
  has_one  :coordinate, :as=>:mapable, :class_name=>"Map"
  validates_uniqueness_of :title, :scope => :parent_id
  validates_presence_of :title

  attr_accessible :title, :parent_id, :position
  
  def self.for_select
    select = Array.new
    Place.public.each do |p|
      select << [p.title, p.id]
      p.children.each do |c|
        select << ["--#{ c.title }", c.id]
      end
    end
    select
  end
end
