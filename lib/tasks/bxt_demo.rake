namespace :bxt do
  desc 'init demo data'
  task demo: :environment do
    h = House.first
    p a = Access.find_by(ip: '10.200.13.39') || Access.create(title: "门禁", parent: h, direction: :in)
    h = a.parent
    c = Student.where(facility_ids: h.id).count
    5.times do |st|
      d = DateTime.now.change(hour: rand(24), min: rand(60))
      d = DateTime.now.change(hour: 5, min: 5)

      s = Student.where(facility_ids: h.id).skip(rand(c)).first
      p Tracker.create(user: s, pass_time: d, access: a)
      Tracker.create(user: s, pass_time: d + 2.hours, access: a)
    end
  end

end