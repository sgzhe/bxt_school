namespace :bxt do
  desc 'init demo data'
  task demo: :environment do
    h = House.first
    p a = FaceAccess.find_by(ip: '10.200.13.39') || FaceAccess.create(title: "门禁", parent: h, direction: :in)
    h = a.parent
    c = Student.where(facility_ids: h.id).count
    25.times do |st|
      d = DateTime.now.change(hour: rand(24), min: rand(60))

      s = Student.where(facility_ids: h.id).skip(rand(c)).first
      p Tracker.create(user: s, pass_time: d, face_access: a).errors
      Tracker.create(user: s, pass_time: d + 2.hours, face_access: a)
    end
  end

end