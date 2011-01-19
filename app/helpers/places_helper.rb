module PlacesHelper
  def draft_record?(record)
    if record.draft?
      "draft tooltips tip_top"
    else
      nil
    end
  end

  def children_places_for place
    if place.children.any?
      capture_haml do
        haml_tag :div, :class=>"item", :style=>"margin-top: 10px;" do
          haml_tag :div, :id=>"place_children" do
            haml_tag :div, t("places.children.title"), :class=>"title"
            place.children.each do |child|
              unless child.draft?
                haml_tag :div, link_to( child.title, place_path(child) ) 
              end
            end
          end
        end
      end
    end
  end

end
