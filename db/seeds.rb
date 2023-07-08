admin = Admin.find_or_create_by(first_name: 'admin', last_name: 'admin', email: 'admin@localhost')
admin.password = 'admin'
admin.save

60.times do |i|
  u = [Manager, Developer].sample.new
  u.email = "email#{i}@mail.gen"
  u.first_name = "FN#{i}"
  u.last_name = "LN#{i}"
  u.password = "#{i}"
  u.save
end

25.times do |i|
  d = Developer.first
  m = Manager.first
  t = Task.new
  t.assignee = d
  t.author = m
  t.name = "TN #{i}"
  t.description = "TD #{i}"
  t.save
end
