require 'spec_helper'

describe "places/edit.html.haml" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :new_record? => false,
      :title => "MyString",
      :draft => false
    ))
  end

  it "renders the edit place form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => place_path(@place), :method => "post" do
      assert_select "input#place_title", :name => "place[title]"
      assert_select "input#place_draft", :name => "place[draft]"
    end
  end
end
