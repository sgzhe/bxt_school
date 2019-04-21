json.extract! tracker, :id, :pass_time, :direction, :status, :overtime
p tracker
json.user tracker.user, :id, :name, :sno, :dept_title, :dorm_title, :gender_mark
json.access tracker.access, :id, :title, :ip, :direction
