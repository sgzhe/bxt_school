json.extract! tracker, :id, :pass_time, :direction, :status, :overtime
json.user tracker.user, :id, :name, :dept_title, :dorm_title, :gender_mark
json.access tracker.access, :id, :title, :ip, :direction
