require 'spec_helper'

describe "places/index.html.haml" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :title => "Title",
        :draft => false
      ),
      stub_model(Place,
        :title => "Title",
        :draft => false
      )
    ])
  end

  it "renders a list of places" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
