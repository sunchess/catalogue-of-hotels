# == Schema Information
# Schema version: 20101022162358
#
# Table name: places
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  draft      :boolean
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#  position   :integer         not null
#

require 'spec_helper'

describe Place do
  pending "add some examples to (or delete) #{__FILE__}"
end
