# == Schema Information
# Schema version: 20101222101120
#
# Table name: places
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  draft        :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  parent_id    :integer
#  position     :integer
#  images_count :integer         default(0), not null
#

require 'spec_helper'

describe Place do
  before do
    @place = Factory.build(:place)
    @children = Factory.build(:second_place)
  end

  it "should be valid" do
    @place.should be_valid
  end

  it "should not be valid" do
    @place.title = nil
    @place.should_not be_valid
    @place.should have(1).error_on(:title)
  end

  it "should have access on" do
    @place.should accessible_attributes(:title, :parent_id, :draft, :position)
  end

  context "Destroy place" do
    it "should be deleted" do
      Place.destroy_all
      @place.save
      @place.destroy
      Place.should have(:no).records
    end
  end

  it "should have parent" do
    @children.save!
    @children.parent.should_not be(nil)
  end

  it "should has uniq error on title" do
    @children.save
    @children2 = Factory.build(:main_place)
    @children2.valid?.should be(false)
    @children2.should have(1).error_on(:title)
  end



end
