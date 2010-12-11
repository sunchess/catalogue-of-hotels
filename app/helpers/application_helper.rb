module ApplicationHelper
  
  def flashes
    return nil if flash.empty?
    html = String.new
    %w{notice error alert}.each do | f |
      if flash[f.to_sym]
         html << content_tag(:div,  flash[f.to_sym], :class=>f) 
      end
    end
    html.html_safe
  end
  
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def editable?
    return true if @editable_flag
    false
  end
   
end
