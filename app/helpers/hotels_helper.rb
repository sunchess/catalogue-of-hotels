module HotelsHelper
  def wizzard_steps
    capture_haml do
      haml_tag :div, {:id=>"wizzard"} do 
        haml_tag :div, link_to(t('hotels.add.hotel'), ( @hotel and !@hotel.new_record? ) ? edit_hotel_path(@hotel) : new_hotel_path ), {:class=>has_current("hotels") }
        if @hotel and can?(:update, @hotel)
          haml_tag :div, link_to(t('hotels.add.images'), new_hotel_image_path(@hotel)), {:class=>has_current("hotels/images")}
          haml_tag :div, link_to(t('hotels.add.map') , new_hotel_map_path(@hotel)), {:class=>has_current("hotels/maps")}
          haml_tag :div, link_to(t('hotels.add.rooms'), hotel_rooms_path(@hotel)), {:class=>has_current("rooms")}
          haml_tag :div, link_to(t('hotels.add.confirm'), edit_hotel_confirm_path(@hotel)), {:class=>has_current("hotels/confirms")}
        end
      end
    end
  end

  def hotel_items
    capture_haml do
      haml_tag :a, t("hotels.list"), :href=>hotels_path
      haml_tag :div, :id=>"wizzard" do
        haml_tag :div, link_to(t("hotels.show.hotel"), hotel_path(@hotel)), :class=>has_current("hotels")
        haml_tag :div, link_to(t("hotels.show.images"), hotel_images_path(@hotel)), :class=>has_current("hotels/images")
        haml_tag :div, link_to(t("hotels.show.rooms"), hotel_rooms_path(@hotel)), :class=>has_current("rooms")
        haml_tag :div, link_to(t("hotels.show.maps"), hotel_maps_path(@hotel)), :class=>has_current("hotels/maps")
      end
    end
  end

  def has_current(controller)
    if params[:controller] == controller
      "current"  
    else
      nil
    end
  end

  def hotel_thumb(record)
    if record.images.any? 
     link_to image_tag(record.images.order("id").first.image.url(:thumb) ), hotel_path(record.id)
    else
      link_to image_tag("thumb_no_photo.png"), hotel_path(record.id)
    end
  end

  def show_hotel_thumb(record)
    if record.images.any? 
     link_to image_tag(record.images.order("id").first.image.url(:thumb), :align=>"left", :style=>"padding: 5px 5px 5px 5px" ), hotel_path(record.id)
    else
      link_to image_tag("thumb_no_photo.png"), hotel_path(record.id)
    end
  end
end
