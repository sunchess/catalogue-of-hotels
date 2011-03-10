require 'spec_helper'

describe PagesController do

  describe "GET 'about_us'" do
    it "should be successful" do
      get 'about_us'
      response.should be_success
    end
  end

  describe "GET 'email'" do
    it "should be successful" do
      get 'email'
      response.should be_success
    end
  end

  describe "GET 'hotel_question'" do
    it "should be successful" do
      get 'hotel_question'
      response.should be_success
    end
  end

end
