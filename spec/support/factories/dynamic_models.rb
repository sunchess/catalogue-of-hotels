Factory.sequence :title do |n|
    "Place#{n}"
end

Factory.define :dynamic_model do |d|
  d.title "Place"
end

Factory.define :dynamic_field do |d|
  d.title "Has one room"
  d.association :dynamic_model, :factory => :dynamic_model
end


