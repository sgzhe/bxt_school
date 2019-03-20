namespace :bxt do
  desc 'init demo data'
  task demo: :environment do
    10.times do |i|
      college = College.create(title: "学院#{i}")
      department = Department.create(title: "系部#{i}", college: college) do |d|
        d.grades.build(mark: '01', title: '大一')
        d.grades.build(mark: '02', title: '大二')
        d.grades.build(mark: '03', title: '大三')
        d.grades.build(mark: '04', title: '大四')
        d.grades.build(mark: '05', title: '大五')
      end
      classroom = Classroom.create(title: "班级#{i}", department: department, grade_mark: "0#{(i % 5)+1}")
      house = House.create(title: "楼栋#{i}") do |h|
        h.floors.build(mark: '01', title: '一楼')
        h.floors.build(mark: '02', title: '二楼')
        h.floors.build(mark: '03', title: '三楼')
        h.floors.build(mark: '04', title: '四楼')
        h.floors.build(mark: '05', title: '五楼')
      end
      gateway = Gateway.create(title: "#{house.title}门禁", parent: house)
      room = Room.create(title: "#{i}0#{i}室", house: house, floor_mark: "0#{(i % 5)+1}")
      student = Student.create(name: "学生#{i}", classroom: classroom, room: room)
      teacher = Teacher.create(name: "教师#{i}", department: department)
      bed = Bed.create(title: "#{i}床", room: room, owner: student)
    end
    group = Group.create(title: '校组')
    role = Role.create(title: '校管', groups: [group])
    manager = Manager.create(name: "管理员", login: 'admin', password: 'bxt-admin', roles: [role])
  end
end