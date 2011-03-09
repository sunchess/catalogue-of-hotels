module ReservesHelper
  def reserve_links(reserve)
    if reserve.room
      link_to(t(".links_#{reserve.status}"), publish_room_reserf_path(reserve.room, reserve), :confirm=>t("confirm")).html_safe
    elsif reserve.offer
      link_to(t(".links_#{reserve.status}"), publish_offer_reserf_path(reserve.offer, reserve), :confirm=>t("confirm")).html_safe
    end
  end

  def reserve_show_prices(room)
    capture_haml do
      haml_tag :table do
        room.prices.each do |price|
          haml_tag :tr, show_price_list(price)
        end
      end
    end
  end
end
