Factory.define :reserf do |t|
  t.room_id 1
  t.association :user, :factory => :user
  t.status 0
  t.name "Alex Ivanov"     
  t.address "Rostov-on-Don, Steet 123"
  t.telephone "123-345"
  t.list_tourists "Alex Ivanov"
  t.coming_on Time.now + 3.day
  t.outing_on  Time.now + 13.day
  t.cost 123.333
  t.discount 5
  t.discount_sum 2.44
  t.min_prepayment 34.434
  t.sum_with_discount 120.3
  t.description "Post post"
end
