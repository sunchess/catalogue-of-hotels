require 'spec_helper'

describe "places/new.html.haml" do
  before(:each) do
    assign(:place, stub_model(Place,
      :title => "MyString",
      :draft => false
    ).as_new_record)
  end

  it "renders new place form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => places_path, :method => "post" do
      assert_select "input#place_title", :name => "place[title]"
      assert_select "input#place_draft", :name => "place[draft]"
    end
  end
end
