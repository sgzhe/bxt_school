json.extract! tracker, :id, :pass_time, :direction, :status, :overtime
json.user tracker.user, :id, :name, :sno, :dept_title, :dorm_title, :gender_mark, :avatar
json.access tracker.access, :id, :title, :ip, :direction, :parent_id
