module Admin::ReservesHelper
  def admin_reserve_link(reserve)
    if reserve.status < 5 # архив
      link_to(t(".links_#{reserve.status}"), admin_reserf_path(reserve.id), :confirm=>t("confirm"), :method=>:put ).html_safe
    else
      nil
    end
  end
end
