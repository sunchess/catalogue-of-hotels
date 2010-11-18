require 'spec_helper'

describe "hotels/show.html.haml" do
  before(:each) do
    @hotel = assign(:hotel, stub_model(Hotel,
      :name => "Name",
      :description => "MyText",
      :distance => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
