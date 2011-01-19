# == Schema Information
# Schema version: 20110114173256
#
# Table name: dynamic_models
#
#  id    :integer         not null, primary key
#  title :string(255)
#

class DynamicModel < ActiveRecord::Base

  has_many :dynamic_fields, :dependent => :destroy, :order=>"position", :conditions=>{:draft=>false}

  validates :title, :length=>{:minimum=>3}, :uniqueness=>true
  validate :must_be_models_name


  attr_accessible :title

  private
  def must_be_models_name
    return true if Rails.env == "development"  #developmint mode is not caching records names
    models_list = get_models_list
    errors.add(:title, I18n.t("activerecord.errors.not_record_name")) unless models_list.include? title.to_s
  end

  def get_models_list
    found = []
    ObjectSpace.each_object(Class) do |klass|
      found << klass.to_s if klass.ancestors.include?(ActiveRecord::Base)
    end
    #puts found
    found
  end

  def self.return_dynamic_fields(model) 
    record = DynamicModel.find_by_title(model)
    dynamic_fields = Array.new
    if record
      dynamic_fields = if record.dynamic_fields.any?
                          record.dynamic_fields
                       end
    end
    dynamic_fields
  end
end
