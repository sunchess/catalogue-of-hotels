module RoomsHelper
  #get data to from model for human
  #human_room_data(room.palces, Room.places) => I18n.t("rooms.new_record.p1")
  def human_room_data(number, array)
    array = array.delete_if{|ele| ele[1]!=number}
    if array.any?
     " #{ array.first.first }<br/> ".html_safe
    else
      nil
    end
  end

  def room_thumb(record)
    if record.images.any? 
     link_to image_tag(record.images.order("id").first.image.url(:thumb) ), hotel_room_path(record.hotel.id, record.id)
    else
      image_tag("thumb_no_photo.png")
    end
  end

  def show_price(price)
    if price == 0
      price = t("rooms.hotel_closed") 
    else
      price = number_to_currency( price )
    end
    price
  end

  def js_image_tumb(images)
    if images.any? 
      link_to image_tag(@images.first.image.url(:thumb)), @images.first.image.url(:large), :rel=>"img_group"
    else
      image_tag("thumb_no_photo.png")
    end
  end

  def show_price_list(price)
    html = ""
    html << content_tag(:td, "#{I18n.t("date.standalone_month_names")[price.month]}:", :class=>price.month == Time.now.get_month ? "current" : nil)
    html << content_tag(:td, "#{show_price( price.cost )} ", :class=>price.month == Time.now.get_month ? "current" : nil) 
    html.html_safe
  end
end
