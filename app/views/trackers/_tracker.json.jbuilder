json.extract! tracker, :id, :pass_time, :direction, :status, :overtime
json.user tracker.user, :id, :name
json.access tracker.access, :id, :title
