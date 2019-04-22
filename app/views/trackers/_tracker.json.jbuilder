json.extract! tracker, :id, :pass_time, :direction, :status, :overtime, :snapshot,
              :user_name, :user_sno, :user_dept_title, :user_dorm_title, :user_avatar_url
#json.user tracker.user, :id, :name, :sno, :dept_full_title, :dorm_full_title, :gender_mark, :avatar
json.access tracker.access, :id, :title, :ip, :direction, :parent_id
