class Room < ActiveRecord::Base
  belongs_to :hotel

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
end
