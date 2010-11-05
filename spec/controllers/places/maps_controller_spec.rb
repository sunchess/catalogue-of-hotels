require 'spec_helper'

describe Places::MapsController do
  before(:all) do
    @map = Factory(:map_place)
  end

  it "should save map" do
    post :create, :place_id=>@map.mapable.id, :map=>{:lat=>23.3544, :lng=>33.3444, :zoom=>5}
  end
end
