# == Schema Information
# Schema version: 20101101133212
#
# Table name: dynamic_models
#
#  id    :integer         not null, primary key
#  title :string(255)
#

class DynamicModel < ActiveRecord::Base

  has_many :dynamic_fields, :dependent => :destroy, :order=>"position", :conditions=>{:draft=>false}

  validates :title, :length=>{:minimum=>3}, :uniqueness=>true
  validate :must_be_model_name


  attr_accessible :title

  private
  def must_be_model_name
    return true if Rails.env == "development"  #developmint mode is not caching models names
    models_list = get_models_list
    errors.add(:title, I18n.t("activerecord.errors.not_model_name")) unless models_list.include? title.to_s
  end

  def get_models_list
    found = []
    ObjectSpace.each_object(Class) do |klass|
      found << klass.to_s if klass.ancestors.include?(ActiveRecord::Base)
    end
    #puts found
    found
  end

end
