json.extract! student, :id, :org_id, :facility_id, :role_ids, :group_ids, :name, :gender_mark, :id_card, :ic_card, :tel, :created_at, :updated_at
# json.classroom do
#   json.partial! "classrooms/classroom", classroom: student.classroom || Classroom.new
# end
# json.room do
#   json.partial! "rooms/room", room: student.room || Room.new
#end
json.groups student.groups, :id, :title, :created_at, :updated_at
json.roles student.roles, :id, :title, :created_at, :updated_at
json.department student.department, :id, :title
json.college student.college, :id, :title
json.house student.house, :id, :title