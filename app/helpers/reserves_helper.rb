module ReservesHelper
  def reserve_links(reserve)
    link_to(t(".links_#{reserve.status}"), publish_reserf_path(reserve), :confirm=>t("confirm")).html_safe
  end
end
