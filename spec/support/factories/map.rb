Factory.define :map do |p|
  p.lat 44.349937
  p.lng 43.349937
  p.zoom 6
end

Factory.define :map_place, :parent=>:map do |p|
  p.lat 44.349937
  p.lng 43.349937
  p.zoom 6
  p.association :mapable, :factory => :place
end