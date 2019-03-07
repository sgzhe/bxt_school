namespace :bxt do
  desc 'init demo data'
  task demo: :environment do
    1..10.times do |i|
      college = College.create(title: "学院#{i}")
      department = Department.create(title: "系部#{i}", college: college)
      classroom = Classroom.create(title: "班级#{i}", department: department)
      house = House.create(title: "楼栋#{i}")
      floor = Floor.create(title: "楼层#{i}", house: house)
      room = Room.create(title: "#{i}0#{i}室", floor: floor)
      bed = Bed.create(title: "#{i}床", room: room)
      student = Student.create(name: "学生#{i}", classroom: classroom, bed: bed)
      teacher = Teacher.create(name: "教师#{i}", department: department)
    end
    manager = Manager.create(name: "管理员", login: 'admin', password: 'bxt-admin')
  end
end