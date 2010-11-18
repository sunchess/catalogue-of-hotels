Factory.define(:user) do |u|
  u.email "user@email.ru"
  u.password "123123"
  u.confirmed_at 3.days.ago
  u.role_mask 0
end


Factory.define(:admin, :parent=>:user) do |a|
  a.email "admin@email.ru"
  a.password "123123"
  a.confirmed_at 3.days.ago
  a.role_mask 1
end
