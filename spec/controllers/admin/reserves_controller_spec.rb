require 'spec_helper'

describe Admin::ReservesController do
  login_admin

  before do
    @reserf = Factory.create(:reserf)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "PUT update" do
    it "should updated with next element" do
      Reserf.should_receive(:find).with(1).and_return(@reserf)
      next_status = @reserf.status + 1
      @reserf.should_receive(:update_attribute).with([ :status, next_status])
      put :update, :room_id => @reserf.room_id
      @reserf.status.should be(next_status)
    end
  end

end
