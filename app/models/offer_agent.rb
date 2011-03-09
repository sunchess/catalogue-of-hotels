class OfferAgent < ActiveRecord::Base
  attr_accessible :name, :details

  has_many :offers
  validates_presence_of :name, :details
end
