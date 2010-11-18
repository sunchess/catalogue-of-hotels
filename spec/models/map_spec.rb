# == Schema Information
# Schema version: 20101115183243
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

require 'spec_helper'

describe Map do
  before do
    @map =  Factory.build(:map)
    @place = Factory(:place)
  end

  it "should be saved" do
    @place.coordinate = @map
    Map.should have(1).record
  end

  it "should be valid" do
    @map.valid?.should be(true)
  end

  it "should have presents errors" do
    @map.lat = nil
    @map.lng = nil
    @map.zoom = nil
    @map.should have(2).error_on(:lat)
    @map.should have(2).error_on(:lng)
    @map.should have(2).error_on(:zoom)
  end

  it "should have access on" do
    @map.should accessible_attributes(:lat, :lng, :zoom)
  end

end
