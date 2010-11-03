# == Schema Information
# Schema version: 20101101133212
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  role_mask            :integer
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'
require 'user'

describe User do
  
  it 'should has role admin' do
    user = User.new
    user.role = :admin
    user.role_mask.should == 1
  end
  
  
end
