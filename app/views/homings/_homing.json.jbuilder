json.extract! homing, :id, :name, :sno, :dept_full_title, :dorm_full_title, :direction_at_last,
              :status_at_last, :pass_time_at_last, :overtime_at_last, :confirmed_at_last, :cause_at_last,
              :reside, :avatar_url, :status, :created_at, :updated_at
json.avatar_url(homing.avatar.url)
