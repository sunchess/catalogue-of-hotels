require File.dirname(__FILE__) + '/acceptance_helper'

feature "Manage Dynamic Models", %q{
  In order to make a model
  As an admin
  I want to create and manage models
} do

  let :admin do
    Factory :admin
  end

  background do
    log_in_with admin
  end

  scenario "create dynamic model" do
    visit dynamic_models("new")
    should_be_on(dynamic_models("new"))
    fill_the_following(
      "dynamic_model_title"=>"Place"
    )
    click_button "dynamic_model_submit"
    should_have_table("//table[@id='dynamic-models-table']",
    ["Place"]
    )
  end

  scenario "invalid dynamic model" do
    visit dynamic_models("new")
    fill_the_following(
      "dynamic_model_title"=>"Er"
    )
    click_button "dynamic_model_submit"
    should_have_ar_errors
  end

  scenario "delete dynamic model" do
    first = Factory(:dynamic_model)
    second = Factory(:dynamic_model, :title=>"User")
    visit dynamic_models
    should_have_table("//table[@id='dynamic-models-table']",
    ["Place"],
    ["User"])
    delete_record("model-#{second.id}", "//table[@id='dynamic-models-table']")
    should_have_table("//table[@id='dynamic-models-table']",
    ["Place"])
  end
end
