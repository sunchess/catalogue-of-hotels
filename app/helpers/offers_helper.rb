module OffersHelper
  def offer_thumb(record)
    if record.images.any? 
     link_to image_tag(record.images.order("id").first.image.url(:thumb) ), offer_path(record.id)
    else
      image_tag("thumb_no_photo.png")
    end
  end
end
