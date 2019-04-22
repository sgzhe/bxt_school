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
    5.times do |cc|
      houses << House.create(title: "楼栋#{cc}")
      colleges << College.create(title: "学院#{cc}")
    end

    houses.each do |house|
      house.floors.create(title: '一楼')
      house.floors.create(title: '二楼')
      house.floors.create(title: '三楼')
      house.floors.create(title: '四楼')
      house.floors.create(title: '五楼')
      house.floors.each do |f|
        20.times do |ro|
          rooms << Room.create(title: "#{ro}", floor: f) do |r|
            8.times { |t| r.beds.build(mark: t) }
          end
        end
        gates << Gate.create(title: "#{house.title}通道", parent: house)
        accesses << Access.create(title: "#{house.title}门禁", parent: house)
        Webcam.create(title: "摄像机", parent: house)
        VideoRecorder.create(title: "录像机", parent: house)
      end
    end

    colleges.each do |college|
      5.times do |d|
        departments << Department.create(title: "系部#{d}", college: college)
      end
    end

    departments.each do |department|
      5.times do |i|
        classrooms << Classroom.create(title: "班级#{i}", department: department)
        Teacher.create(name: "教师#{rand(999)}", department: department)
      end
    end

    classrooms.each do |classroom|
      10.times do |s|
        students << Student.create(name: "学生#{rand(99999)}-#{s}", dept: classroom)
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