json.extract! student, :id, :bed_mark, :room_id, :house_id, :classroom_id,
              :department_id, :college_id, :dept_title, :dorm_title,
              :direction_at_last, :status_at_last, :pass_time_at_last, :overtime_at_last, :reside,
              :role_ids, :group_ids, :name, :gender_mark, :id_card, :ic_card, :tel, :avatar, :created_at, :updated_at
# json.classroom do
#   json.partial! "classrooms/classroom", classroom: student.classroom || Classroom.new
# end
# json.room do
#   json.partial! "rooms/room", room: student.room || Room.new
#end
#json.groups student.groups, :id, :title, :created_at, :updated_at
#json.roles student.roles, :id, :title, :created_at, :updated_at
