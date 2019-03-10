namespace :bxt do
  desc 'init demo data'
  task demo: :environment do
    1..10.times do |i|
      college = College.create(title: "学院#{i}")
      department = Department.create(title: "系部#{i}", college: college)
      classroom = Classroom.create(title: "班级#{i}", department: department)
      house = House.create(title: "楼栋#{i}")
      room = Room.create(title: "#{i}0#{i}室", house: house, floor: "0#{i}")
      student = Student.create(name: "学生#{i}", classroom: classroom, room: room)
      teacher = Teacher.create(name: "教师#{i}", department: department)
      bed = Bed.create(title: "#{i}床", room: room, charge_person: student)
    end
    group = Group.create(title: '校组')
    role = Role.create(title: '校管', groups: [group])
    manager = Manager.create(name: "管理员", login: 'admin', password: 'bxt-admin', roles: [role])
  end
end