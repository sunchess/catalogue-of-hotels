# == Schema Information
# Schema version: 20110114173256
#
# Table name: images
#
#  id                 :integer         not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  imageable_type     :string(255)
#  imageable_id       :integer
#  draft              :boolean         default(TRUE), not null
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Image do
  before do
    @map =  Factory.build(:map)
    @place = Factory(:place)
  end
end
