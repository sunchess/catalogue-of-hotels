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
  DISCOUNT = 5
  belongs_to :user
  belongs_to :orderable, :polymorphic => true
  attr_accessible :name, :address, :telephone, :list_tourists, :coming_on, :outing_on, :description, :all_tourists

  validates_presence_of :name, :address, :telephone, :list_tourists, :coming_on, :outing_on, :all_tourists
  validates_numericality_of :all_tourists, :greater_than => 0
  validate :validate_dates

  before_save :save_cost

  scope :ordered, order("id DESC")
  scope :draft, where(:status=>0)
  scope :sent, where(:status=>1)
  scope :adopted, where(:status=>2)
  scope :confirmed, where(:status=>3)
  scope :paid, where(:status=>4)
  scope :archive, where(:status=>5) 
  scope :canceled, where(:status=>6) 

  scope :statused, lambda{|s|
    if [0, 1, 2, 3, 4, 5, 6].include? s.to_i
      where(:status=>s)
    else
      where(:status=>0)
    end
  }

  scope :status_in, lambda{|s_array|
    where(:status=>s_array)
  }
  
  def room
    if self.orderable_type == "Room"
      self.orderable 
    else
      nil
    end
  end

  def offer
    if self.orderable_type == "Offer"
      self.orderable 
    else
      nil
    end
  end


  def save_cost
    calculate_res = calculate()
    write_attribute(:cost, calculate_res[:sum])   
    write_attribute(:discount_sum, calculate_res[:discount_sum])
    write_attribute(:min_prepayment, calculate_res[:min_prepayment])
    write_attribute(:sum_with_discount, calculate_res[:sum_with_discount])
  end

  def validate_dates
    errors.add(:coming_on, I18n.t("reserves.errors.mast_be_greater_now")) if !coming_on.blank? and coming_on.to_time < 1.day.from_now 
    errors.add(:outing_on, I18n.t("reserves.errors.mast_be_greater_coming_on")) if !outing_on.blank? and outing_on.to_time <= coming_on.to_time
  end

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
      when 5
        I18n.t("reserves.status.archive")
      when 6
        I18n.t("reserves.status.canceled")
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
    return nil if ( !coming_on or !outing_on ) or coming_on > outing_on 
    if room
      # Если дата вселения больше чем дата выселения или в эти месяцы не работает гостиница
      return nil if room.prices.find_by_month(coming_on.mon).cost == 0 or room.prices.find_by_month(outing_on.mon).cost == 0 
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
      min_prepayment =  ( (cost.to_f * ( PREPAYMENT_PERCENT.to_f / 100) ) - discount_sum )
    elsif offer
      return nil if !all_tourists or all_tourists.zero?
      self.discount = offer.discount
      number_of_days = (outing_on - coming_on).to_i
      cost = ( number_of_days * offer.price ) * all_tourists
      discount_sum = ( cost.to_f * ( self.discount.to_f / 100 ) )
      min_prepayment =  ( (cost.to_f * ( offer.fee.to_f / 100) ) - discount_sum )
    end
    {:sum => cost, :discount_sum => discount_sum, :sum_with_discount => cost.to_f - discount_sum, :min_prepayment => min_prepayment}
  end

  private
  def default_values
    write_attribute(:discount, DISCOUNT) if new_record?
  end

end
