# == Schema Information
# Schema version: 20110114173256
#
# Table name: dynamic_models
#
#  id    :integer         not null, primary key
#  title :string(255)
#

require 'spec_helper'

describe DynamicModel do

  before do
    @model = Factory.build(:dynamic_model)
  end

  it "should be valid" do
    @model.should be_valid
  end

  it "should not be valid" do
    @model.title = "Er"
    @model.should_not be_valid
    @model.should have(2).error_on(:title)
  end

  it "should have access on title" do
    @model.save!
    @model.should accessible_attributes(:title)
  end

  context "Destroy dynamic model"

  it "should be deleted" do
    DynamicModel.destroy_all
    @model = Factory(:dynamic_model)
    @model.destroy
    DynamicModel.should have(:no).records
  end



end
