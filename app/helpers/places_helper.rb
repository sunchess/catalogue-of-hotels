module PlacesHelper
  def draft_record?(record)
    if record.draft?
      "draft tooltips tip_top"
    else
      nil
    end
  end
end
