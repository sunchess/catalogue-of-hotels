# == Schema Information
# Schema version: 20110114173256
#
# Table name: hotels
#
#  id                    :integer         not null, primary key
#  place_id              :integer
#  user_id               :integer
#  name                  :string(255)
#  description           :text
#  street                :string(255)
#  house_number          :string(255)
#  telephone             :text
#  fax                   :string(255)
#  distance              :integer
#  draft                 :boolean         default(TRUE), not null
#  paid_placement        :boolean         not null
#  banking_details       :text
#  created_at            :datetime
#  updated_at            :datetime
#  images_count          :integer         default(0), not null
#  confirmed             :boolean         not null
#  contract_file_name    :string(255)
#  contract_content_type :string(255)
#  contract_file_size    :integer
#

class Hotel < ActiveRecord::Base
  acts_as_list 

  acts_as_commentable

  scope :confirmed, where(:draft=>true, :confirmed=>true).order("id")
  scope :public_items, where(["draft=? and (confirmed=? OR paid_placement=?)", false, true, false]).order("position")
  scope :not_confirmed, where(["draft=? and confirmed=?", true, false ]).order("position")

  belongs_to :user
  belongs_to :place
  attr_accessible :name, :description, :distance, :place_id, :street, :house_number, :telephone, :fax, :banking_details, :contract, :confirmed, :site, :email

  validates_presence_of :name, :description, :distance, :street, :house_number, :telephone, :place_id
  validates_format_of :email, :with => Devise.email_regexp, :allow_blank => true
  validates_format_of :site, :with => /^http:\/\//, :allow_blank => true, :message => I18n.t("hotels.errors.site")

  has_many :images, :as=>:imageable, :dependent => :destroy, :order=>"id"
  has_many :fields_dynamic_fields, :as=>:dynamic, :dependent => :destroy
  has_many :dynamic_fields, :through=>:fields_dynamic_fields
  has_one  :coordinate, :as=>:mapable, :class_name=>"Map"
  has_many :rooms

  # Paperclip
  has_attached_file :contract

  def save_dynamic_fields(fields)
    if fields
      self.dynamic_fields.clear
      fields.each do |field|
        self.dynamic_fields << DynamicField.find_by_permalink(field)
      end 
    else
      self.dynamic_fields.clear
    end 
  end

  def has_all_params
    self.images.any? and self.coordinate and self.rooms.any?
  end

  def self.draft
    count("id", :conditions=>{:draft=>true, :confirmed=>true})  
  end

  def self.count_not_confirmed
    count("id", :conditions=>{:draft=>true, :confirmed=>false})  
  end

  def rooms_exept(room)
    self.rooms.delete_if{|r| r.id == room.id }
  end

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
