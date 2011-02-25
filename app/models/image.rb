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

class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true, :counter_cache => true

  scope(:limited, :limit=>6, :order=>"created_at DESC")
  scope(:not_draft, where(:draft=>false))
  scope(:draft, where(:draft=>true))
  scope(:ordered, order("id DESC"))

  attr_accessible :image, :draft

  # Paperclip
  has_attached_file :image,
    :styles => {
    :thumb=> "100x100#",
    :small  => "150x150#",
    :large =>   "500x500>" }, 
    :convert_options => { :all => "-strip -quality 60"} 

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'IMAGE/JPEG', 'IMAGE/PNG', 'IMAGE/GIF']
end
