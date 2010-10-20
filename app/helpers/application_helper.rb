module ApplicationHelper
  
  def flashes
    return nil if flash.empty?
    
    html = String.new
    %w{notice error}.each do | f |
      if flash[f.to_sym]
         html << content_tag(:div,  flash[f.to_sym], :class=>f) 
      end
    end
    html.html_safe
  end
  
end
