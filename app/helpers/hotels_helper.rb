module HotelsHelper
  def wizzard_steps
    capture_haml do
      haml_tag :div, {:id=>"wizzard"} do 
        haml_tag :div, link_to(t('hotels.add.hotel'), ( @hotel and !@hotel.new_record? ) ? edit_hotel_path(@hotel) : new_hotel_path ), {:class=>has_current("hotels") }
        haml_tag :div, link_to(t('hotels.add.images'), ( @hotel and !@hotel.new_record? ) ? hotel_images_path(@hotel) : nil), {:class=>has_current("hotels/images")}
        haml_tag :div, link_to(t('hotels.add.map') ), {:class=>has_current("hotels/map")}
        haml_tag :div, link_to(t('hotels.add.rooms') ), {:class=>has_current("hotels/rooms")}
        haml_tag :div, link_to(t('hotels.add.contract') ), {:class=>has_current("hotels/contract")}
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
end
