# == Schema Information
# Schema version: 20101022162358
#
# Table name: dynamic_fields
#
#  id               :integer         not null, primary key
#  dynamic_model_id :integer
#  title            :string(255)
#  permalink        :string(255)
#  position         :integer
#

class DynamicField < ActiveRecord::Base
  acts_as_list :scope => :dynamic_model
  
  validates :title, :length => { :minimum => 3 }

  
  has_many :fields_dynamic_fields, :dependent => :destroy
  belongs_to :dynamic_model

  attr_accessible :title, :draft, :position

  before_save :set_permalink

  private

  def set_permalink
    self.permalink = Russian.translit(title).mb_chars.downcase.parameterize("_")
  end

end
