module NavigationHelper
  def set_current_style(*agrc)
    return nil if agrc.nil?
    agrc.include?(params[:controller].to_s) ? "current" : nil
  end
end
