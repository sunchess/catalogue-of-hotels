# == Schema Information
# Schema version: 20101101133212
#
# Table name: dynamic_fields
#
#  id               :integer         not null, primary key
#  dynamic_model_id :integer
#  title            :string(255)
#  permalink        :string(255)
#  position         :integer
#  draft            :boolean
#

require 'spec_helper'

describe DynamicField do
  before do
    @field = Factory.build(:dynamic_field)
  end

  it "should be valid and access on title" do
    @field.should be_valid
    @field.should accessible_attributes(:title, :position, :draft)
  end

  it "should have dynamic model" do
    @field.save!
    @field.dynamic_model.should eq(DynamicModel.first)
  end

  it "should have 1 error" do
    @field.title = "Er"
    @field.should_not be_valid
    @field.should have(1).error_on(:title)
  end

  it "should have permalink" do
    @field.save!
    @field.permalink.should eq("has_one_room")
  end
end
