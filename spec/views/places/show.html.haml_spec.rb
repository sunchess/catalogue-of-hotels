require 'spec_helper'

describe "places/show.html.haml" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :title => "Title",
      :draft => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
