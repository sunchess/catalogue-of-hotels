require 'spec_helper'

describe "hotels/edit.html.haml" do
  before(:each) do
    @hotel = assign(:hotel, stub_model(Hotel,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :distance => 1
    ))
  end

  it "renders the edit hotel form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => hotel_path(@hotel), :method => "post" do
      assert_select "input#hotel_name", :name => "hotel[name]"
      assert_select "textarea#hotel_description", :name => "hotel[description]"
      assert_select "input#hotel_distance", :name => "hotel[distance]"
    end
  end
end
