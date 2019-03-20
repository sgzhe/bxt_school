json.extract! attendance, :created_at, :updated_at
json.user attendance.user, :id, :name
json.attendances attendance.attendances, :day, :status

