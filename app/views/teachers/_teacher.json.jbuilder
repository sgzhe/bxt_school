json.extract! teacher, :id, :dept_id, :facility_id, :role_ids, :group_ids,
              :dept_full_title, :dorm_full_title,
              :name, :login, :gender_mark, :id_card, :ic_card, :tel, :created_at, :updated_at
json.avatar_url(teacher.avatar.url)
