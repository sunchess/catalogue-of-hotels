Given /^the following dynamic_models:$/ do |dynamic_models|
  DynamicModel.create!(dynamic_models.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) dynamic_model$/ do |pos|
  visit dynamic_models_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link t("destroy")
  end
end

Then /^I should see the following dynamic_models:$/ do |expected_dynamic_models_table|
  expected_dynamic_models_table.diff!(tableish('table tr', 'td,th'))
end
