module ApplicationHelper

  def t_will_paginate(collection, options = {})
    options.update({:previous_label=>t("paginate.previous")})
    options.update({:next_label=>t("paginate.next")})
    will_paginate(collection, options)
  end

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
   
  def _date(date)
    Russian::strftime(date, "%d %B %Y")
  end

  def remote_submit_tag(name, url)
    capture_haml do
      haml_tag(:input, {:name=>name, :type=>"button", :onclick=>"$.ajax({ type: 'POST', url: '#{url}',  data: $(form).serialize()}); return false;", :value=>name })
    end
  end
end
