require 'spec_helper'

describe "Places" do
  describe "GET /places" do
    it "works!" do
      get places_path
    end
  end

  describe "GET /dynamic_models" do
    it "works!" do
      get dynamic_models_path
    end
  end

end
