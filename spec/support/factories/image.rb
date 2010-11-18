Factory.define :image do | i |
  i.image File.new(Rails.root.to_s+ "/spec/support/DSCN3194.JPG")
end
