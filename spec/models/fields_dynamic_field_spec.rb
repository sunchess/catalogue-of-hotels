# == Schema Information
# Schema version: 20101101133212
#
# Table name: fields_dynamic_fields
#
#  id               :integer         not null, primary key
#  dynamic_field_id :integer
#  dynamic_id       :integer
#  dynamic_type     :string(255)
#

require 'spec_helper'

describe FieldsDynamicField do
  it "should have a record" do
    @field = Factory.build(:dynamic_field)
    @place = Factory(:place)
    @place.dynamic_fields << @field
    FieldsDynamicField.should have(1).record
  end
end
