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

class Reserve < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  attr_accessible :name, :address, :telephon, :list_turists, :coming, :outing

  validates_presence_of :name, :address, :telephon, :list_turists, :coming, :outing
end
