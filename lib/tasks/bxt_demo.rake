namespace :bxt do
  desc 'init demo data'
  task demo: :environment do
    colleges = []
    departments = []
    classrooms = []
    houses = []
    rooms = []
    students = []
    gates = []
    accesses = []
    5.times do |c|
      houses << House.create(title: "楼栋#{c}") do |h|
        h.floors.build(mark: '01', title: '一楼')
        h.floors.build(mark: '02', title: '二楼')
        h.floors.build(mark: '03', title: '三楼')
        h.floors.build(mark: '04', title: '四楼')
        h.floors.build(mark: '05', title: '五楼')
      end
      houses[c].floors.each do |f|
        20.times do |r|
          rooms << Room.create(title: "#{c}-#{f.mark}-#{r}", house: houses[c], floor_mark: f.mark) do |r|
            8.times { |t| r.beds.build(mark: t) }
          end
        end
        gates << Gate.create(title: "#{houses[c].title}通道#{f.mark}", parent: houses[c])
        accesses << Access.create(title: "#{houses[c].title}门禁#{f.mark}", parent: houses[c])
        Webcam.create(title: "摄像机#{f.mark}", parent: houses[c])
        VideoRecorder.create(title: "录像机#{f.mark}", parent: houses[c])
      end

      colleges << College.create(title: "学院#{c}")
      5.times do |d|
        departments << Department.create(title: "系部#{d}", college: colleges[c])
        5.times do |i|
          classrooms << Classroom.create(title: "班级#{c}-#{d}-#{i}", department: departments[d])
          10.times do |s|
            students << Student.create(name: "学生#{d*i*5}-#{s}", classroom: classrooms[i])
          end
        end
        teacher = Teacher.create(name: "教师#{c+d}", sno: "#{c*5 + d}", department: departments[d])
      end
    end

    index = 0
    rooms.each do |r|
      8.times do |t|
        s = students[index]
        if s
          r.check_in(s)
          index += 1
        end
      end
    end

    50.times do |st|
      d = DateTime.now.change(hour: rand(24), min: rand(60))
      Tracker.create(user: students[st], pass_time: d, access: accesses[rand(5)])
      Tracker.create(user: students[st], pass_time: d + 2.hours, access: accesses[rand(5)])
    end

    group = Group.create(title: '校组')
    role = Role.create(title: '校管', groups: [group])
    manager = Manager.create(name: "管理员", login: 'admin', password: 'bxt-admin', roles: [role])
  end
end