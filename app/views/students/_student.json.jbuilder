json.extract! student, :id, :name, :gender, :id_card, :ic_card, :tel, :created_at, :updated_at
json.classroom do
  json.partial! "classrooms/classroom", classroom: student.classroom || Classroom.new
end
json.bed do
  json.partial! "beds/bed", bed: student.bed || Bed.new
end
json.groups student.groups, :id, :title, :created_at, :updated_at
json.roles student.roles, :id, :title, :created_at, :updated_at