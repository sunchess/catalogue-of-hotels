require 'spec_helper'

describe "hotels/new.html.haml" do
  before(:each) do
    assign(:hotel, stub_model(Hotel,
      :name => "MyString",
      :description => "MyText",
      :distance => 1
    ).as_new_record)
  end

  it "renders new hotel form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => hotels_path, :method => "post" do
      assert_select "input#hotel_name", :name => "hotel[name]"
      assert_select "textarea#hotel_description", :name => "hotel[description]"
      assert_select "input#hotel_distance", :name => "hotel[distance]"
    end
  end
end
