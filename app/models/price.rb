# == Schema Information
# Schema version: 20110114173256
#
# Table name: prices
#
#  id         :integer         not null, primary key
#  room_id    :integer
#  month      :integer
#  cost       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Price < ActiveRecord::Base
  belongs_to :room
  attr_accessible :month, :cost
  
  validates_presence_of :month
  validates_numericality_of :cost

  scope :not_zero, where("cost >  0")
    
end
