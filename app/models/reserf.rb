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
  after_initialize :default_values
  
  PREPAYMENT_PERCENT = 20
  belongs_to :user
  belongs_to :room
  attr_accessible :name, :address, :telephone, :list_tourists, :coming_on, :outing_on, :description

  validates_presence_of :name, :address, :telephone, :list_tourists, :coming_on, :outing_on

  validate :validate_dates

  before_save :save_cost

  def save_cost
    write_attribute(:cost, calculate(self.room)[:sum])   
  end

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

  def calculate
    # Если дата вселения больше чем дата выселения или в эти месяцы не работает гостиница
    return nil if ( !coming_on or !outing_on ) or coming_on > outing_on or room.prices.find_by_month(coming_on.mon).cost == 0 or room.prices.find_by_month(outing_on.mon).cost == 0 
    if coming_on.mon == outing_on.mon
     cost = ( ( outing_on - coming_on ).to_i + 1 ) * room.prices.find_by_month(coming_on.mon).cost
    else#считаем каждый день
      current_month = coming_on.mon
      current_cost = room.prices.find_by_month(current_month).cost
      day = coming_on
      cost = current_cost
      cost = 0
      ( outing_on - coming_on ).to_i.times do |time| 
        if day.mon == current_month
          cost += current_cost 
        else
          current_month = day.mon
          current_cost = room.prices.find_by_month(current_month).cost 
          cost += current_cost 
        end
        day = day.next
      end
      cost
    end

    #если больше 50т.р.
    if cost > 50000
      self.discount = 7
    end

    discount_sum = ( cost.to_f * ( self.discount.to_f / 100 ) )
    {:sum => cost, :discount_sum => discount_sum, :sum_with_discount => cost.to_f - discount_sum, :min_prepayment => ( (cost.to_f * ( PREPAYMENT_PERCENT.to_f / 100) ) - discount_sum )}
  end

  private
  def default_values
    write_attribute(:discount, 5)
  end

end
