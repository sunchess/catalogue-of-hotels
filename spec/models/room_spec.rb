# == Schema Information
# Schema version: 20101222101120
#
# Table name: rooms
#
#  id           :integer         not null, primary key
#  hotel_id     :integer
#  places       :integer
#  room_number  :integer
#  shower       :integer
#  toilet       :integer
#  fridge       :integer
#  tv           :integer
#  images_count :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Room do
  pending "add some examples to (or delete) #{__FILE__}"
end
