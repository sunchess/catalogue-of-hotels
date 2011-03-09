# == Schema Information
# Schema version: 20110114173256
#
# Table name: rooms
#
#  id           :integer         not null, primary key
#  hotel_id     :integer
#  places       :integer
#  room_number  :integer
#  shower       :integer
#  toilet       :integer
#  fridge       :integer
#  tv           :integer
#  images_count :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Room < ActiveRecord::Base
  belongs_to :hotel
  has_many :dynamic_fields, :through=>:fields_dynamic_fields
  has_many :fields_dynamic_fields, :as=>:dynamic, :dependent => :destroy
  has_many :images, :as=>:imageable, :dependent => :destroy
  has_many :prices, :order=>"id", :dependent => :destroy
  has_many :reserves, :as => :orderable


  attr_accessible :places, :room_number, :shower, :toilet, :fridge, :tv, :prices_attributes, :images, :dynamic_fields, :fields_dynamic_fields, :title, :description
  validates_presence_of :places, :title, :room_number, :shower, :toilet
  validates_length_of :description, :within => 100..1000, :allow_blank => true
  accepts_nested_attributes_for :prices, :reject_if => :all_blank, :limit=>12

  validate :must_have_one_price

  def prices_for_list(month = nil)
    # get month and delete 0 if is there?
    month = Time.now.get_month if month.nil?
    months = Array.new
    if (month+4)>12
      month == 12 ? months << 12 : ( month..12 ).each{|m| months << m}
      limit = (( month + 3)-12)
      limit > 1 ? ( 1..limit ).each{|m| months << m} : months << limit
    else
      ( month..( month + 3 ) ).each{|m| months << m}
    end
    self.prices.where(["month IN(?)", months ])
  end

  def min_price
    self.prices.not_zero.map(&:cost).min
  end

  def max_price
    self.prices.not_zero.map(&:cost).max
  end

  def must_have_one_price
    errors.add(:prices_cost, I18n.t( "rooms.prices_empty" )) if prices.empty?
  end

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

  def save_photos(photos)
    return nil unless photos
    photos.each do |photo|
      image = Image.new(:image => photo, :draft=>false)
      self.images << image
    end
  end

  def build_prices_months
    monthes = I18n.t("date.standalone_month_names")
    monthes.each_with_index do |month, idx|
      self.prices.build(:month=>idx) unless idx == 0
    end
  end

  def self.places
    [[I18n.t("rooms.new_record.p1"), 1], [I18n.t("rooms.new_record.p2"), 2], [I18n.t("rooms.new_record.p3"), 3], [I18n.t("rooms.new_record.p4"), 4], [I18n.t("rooms.new_record.p5"), 5]]
  end

  def self.rooms
    [[I18n.t("rooms.new_record.r1"), 1], [I18n.t("rooms.new_record.r2"), 2], [I18n.t("rooms.new_record.r3"), 3]]
  end

  def self.shower
    [[I18n.t("rooms.new_record.shower.in_room"), 1], [I18n.t("rooms.new_record.shower.on_floor"), 2], [I18n.t("rooms.new_record.shower.yard"), 3], [I18n.t("rooms.new_record.shower.beach"), 4]]
  end

  def self.toilet
    [[I18n.t("rooms.new_record.toilet.in_room"), 1], [I18n.t("rooms.new_record.toilet.on_floor"), 2], [I18n.t("rooms.new_record.toilet.yard"), 3]]
  end

  def self.fridge
    [[I18n.t("rooms.new_record.fridge.in_room"), 1], [I18n.t("rooms.new_record.fridge.on_floor"), 2]]
  end

  def self.tv
    [[I18n.t("rooms.new_record.tv.in_room"), 1], [I18n.t("rooms.new_record.tv.in_hall"), 2]]
  end

  def prices_first_half
    self.prices.slice(0, 6)
  end

  def prices_second_half
    self.prices.slice(6, 12)
  end

end
