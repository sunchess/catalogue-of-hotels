# == Schema Information
# Schema version: 20110114173256
#
# Table name: maps
#
#  id           :integer         not null, primary key
#  lat          :float
#  lng          :float
#  zoom         :integer
#  mapable_id   :integer
#  mapable_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Map < ActiveRecord::Base
  attr_accessible :lat, :lng, :zoom

  validates_presence_of :lat, :lng, :zoom
  validates_numericality_of :lat, :lng, :zoom


  belongs_to :mapable, :polymorphic => true

  def set_coordinates(coordinates)
    self.lat = coordinates.first
    self.lng = coordinates.last
    self.zoom = 14
  end
end
