namespace :bxt do
  desc 'init demo data'
  task demo: :environment do
    1..10.times do |i|
      college = College.create(title: "学院#{i}")
      department = Department.create(title: "系部#{i}", college: college)
      classroom = Classroom.create(title: "班级#{i}", department: department)
    end
  end
end