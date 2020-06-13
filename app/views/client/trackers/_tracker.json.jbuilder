json.extract! tracker, :id, :pass_time, :direction, :status, :overtime,
              :user_name, :user_sno, :user_dept_title, :user_dorm_title, :face_id,
              :user_nationality, :access_id, :ic_card
json.user_snapshot_url(tracker.snapshot.url ? base_url+tracker.snapshot.url.to_s : '')
json.user_avatar_url(tracker.user_avatar_url ? base_url+tracker.user_avatar_url.to_s : '')
#json.user tracker.user, :id, :name, :sno, :dept_full_title, :dorm_full_title, :gender_mark, :avatar
#json.access tracker.access, :id, :title, :ip, :direction, :parent_id
