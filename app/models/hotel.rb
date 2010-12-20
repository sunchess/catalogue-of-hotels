# == Schema Information
# Schema version: 20101115183243
#
# Table name: hotels
#
#  id              :integer         not null, primary key
#  place_id        :integer
#  user_id         :integer
#  name            :string(255)
#  description     :text
#  street          :string(255)
#  house_number    :string(255)
#  telephone       :text
#  fax             :string(255)
#  distance        :integer
#  draft           :boolean         default(TRUE), not null
#  paid_placement  :boolean         not null
#  banking_details :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Hotel < ActiveRecord::Base
  scope :public, lambda{|can_manage|
    where(:draft=>can_manage)
  }

  belongs_to :user
  belongs_to :place
  attr_accessible :name, :description, :distance, :place_id, :street, :house_number, :telephone, :fax, :banking_details

  validates_presence_of :name, :description, :distance, :street, :house_number, :telephone, :place_id

  has_many :images, :as=>:imageable, :dependent => :destroy
  has_many :fields_dynamic_fields, :as=>:dynamic, :dependent => :destroy
  has_many :dynamic_fields, :through=>:fields_dynamic_fields
  has_one  :coordinate, :as=>:mapable, :class_name=>"Map"
  has_many :rooms

  def self.distance_options
    {I18n.t('hotels.distance_options.less_five')=>5,
     I18n.t('hotels.distance_options.five_ten')=>10, 
     I18n.t('hotels.distance_options.ten_twenty')=>20, 
     I18n.t('hotels.distance_options.twenty_thirty')=>30,
     I18n.t('hotels.distance_options.half_hour')=>40}.sort{|a,b| a[1]<=>b[1]}
  end

  def self.images_limit
    20
  end

  def geo_place
    place=self.place
    place_part =  if place.parent
            "#{place.title}, #{place.parent.title}"
          else
            place.title
          end

    hotel_part = "#{ self.street }, #{self.house_number}"

    "#{place_part}, #{hotel_part}"
  end
end
