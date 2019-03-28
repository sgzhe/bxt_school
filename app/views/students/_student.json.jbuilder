json.extract! student, :id, :bed_title, :room_id, :room_title, :house_id, :house_title, :classroom_id, :classroom_title,
              :department_id, :department_title, :college_id, :college_title,
              :role_ids, :group_ids, :name, :gender_mark, :id_card, :ic_card, :tel, :created_at, :updated_at
# json.classroom do
#   json.partial! "classrooms/classroom", classroom: student.classroom || Classroom.new
# end
# json.room do
#   json.partial! "rooms/room", room: student.room || Room.new
#end
#json.groups student.groups, :id, :title, :created_at, :updated_at
#json.roles student.roles, :id, :title, :created_at, :updated_at
