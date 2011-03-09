class Offer < ActiveRecord::Base
  acts_as_list 
  attr_accessible :offer_agent_id, :name, :body, :price, :fee, :discount

  belongs_to :offer_agent
  has_many :images, :as => :imageable

  validates_presence_of :offer_agent_id, :name, :body, :price, :fee 
  validates_numericality_of :price, :fee
  validates_numericality_of :discount, :allow_nil => true

  scope :ordered, order("position")
  scope :not_id, lambda{|id| where([ "id <> ?", id ])}

  def self.min_price
    r = minimum('price')
    where(:price => r).first
  end

  def others
    self.class.not_id(self.id).ordered
  end
end
