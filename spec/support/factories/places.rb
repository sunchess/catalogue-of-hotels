Factory.define :place do |p|
  p.title "Ростов-на-Дону"
  p.draft false
end

Factory.define :main_place, :parent => :place  do |p|
  p.title 'Краснодарский край'
  p.draft false
  p.parent_id nil
end

Factory.define :second_place, :parent => :place  do |p|
  p.title 'Сочи'
  p.draft false
  p.association :parent, :factory => :main_place
end





