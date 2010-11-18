require 'spec_helper'

describe "hotels/index.html.haml" do
  before(:each) do
    assign(:hotels, [
      stub_model(Hotel,
        :name => "Name",
        :description => "MyText",
        :distance => 1
      ),
      stub_model(Hotel,
        :name => "Name",
        :description => "MyText",
        :distance => 1
      )
    ])
  end

  it "renders a list of hotels" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
