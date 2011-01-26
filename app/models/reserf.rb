# == Schema Information
# Schema version: 20110114173256
#
# Table name: reserves
#
#  id           :integer         not null, primary key
#  room_id      :integer
#  user_id      :integer
#  status       :integer
#  name         :string(255)
#  address      :string(255)
#  telephon     :string(255)
#  list_turists :text
#  coming       :date
#  outing       :date
#  created_at   :datetime
#  updated_at   :datetime
#

class Reserf< ActiveRecord::Base
  #TODO: Валидация если в месяц вселения или выселения не работает гостиница
  belongs_to :user
  belongs_to :room
  attr_accessible :name, :address, :telephone, :list_tourists, :coming_on, :outing_on, :description

  validates_presence_of :name, :address, :telephone, :list_tourists, :coming_on, :outing_on

  validate :validate_dates

  def validate_dates
    errors.add(:coming_on, I18n.t("reserves.errors.mast_be_greater_now")) if !coming_on.blank? and coming_on.to_time < 1.day.from_now 
    errors.add(:outing_on, I18n.t("reserves.errors.mast_be_greater_coming_on")) if !outing_on.blank? and outing_on.to_time < coming_on + 1.day 
  end

  scope :ordered, order("id DESC")

  def h_status
    case self.status
      when 0
        I18n.t("reserves.status.draft")
      when 1
        I18n.t("reserves.status.sent")
      when 2
        I18n.t("reserves.status.adopted")
      when 3
        I18n.t("reserves.status.confirmed")
      when 4
        I18n.t("reserves.status.paid")
    end
  end

  def change_status
    case self.status
      when 0
        self.update_attribute(:status, 1)
      when 1
        self.update_attribute(:status, 2)
      when 2
        self.update_attribute(:status, 3)
      when 3
        self.update_attribute(:status, 4)
    end
  end

  def calculate(room)
    # Если дата вселения больше чем дата выселения или в эти месяцы не работает гостиница
    return nil if coming_on > outing_on or room.prices.find_by_month(coming_on.mon).cost == 0 or room.prices.find_by_month(outing_on.mon).cost == 0 
    coming_on = self.coming_on
    outing_on = self.outing_on
    if coming_on.mon == outing_on.mon
      ( coming_on - outing_on ) * room.prices.find_by_month(coming_on.mon).cost
    else
      #TODO: вычесление прайса на даты если месяцы не совпадают
    end
  end

  private
  def get_num_days(date)
    date
  end
end
