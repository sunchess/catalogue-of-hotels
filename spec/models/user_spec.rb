require 'spec_helper'
require 'user'

describe User do
  
  it 'should has role admin' do
    user = User.new
    user.role = :admin
    user.role_mask.should == 1
  end
  
  
end
