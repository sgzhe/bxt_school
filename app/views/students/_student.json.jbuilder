json.extract! student, :id, :bed_mark, :dorm_id, :dept_id,
              :dept_full_title, :dorm_full_title, :sno,
              :direction_at_last, :status_at_last, :pass_time_at_last, :overtime_at_last, :reside,
              :role_ids, :group_ids, :name, :gender_mark, :id_card, :ic_card, :tel, :created_at, :updated_at
json.avatar_url(student.avatar.url)
json.dorm_parent_id(student.dorm.parent_id)
