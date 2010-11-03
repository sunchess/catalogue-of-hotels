require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DynamicFieldsHelper. For example:
#
# describe DynamicFieldsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe DynamicFieldsHelper do
  before do
    @field = Factory(:dynamic_field, :draft=>true)
  end

  describe "show draft" do
    it "should show draft true" do
      helper.show_draft(@field).should == I18n.t('dynamic_fields.draft')
    end

    it "should show draft false" do
      @field.draft = false
      helper.show_draft(@field).should == I18n.t('dynamic_fields.not_draft')
    end
  end
end
