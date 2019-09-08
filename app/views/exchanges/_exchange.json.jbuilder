json.extract! exchange, :id, :bed_mark, :dorm_id, :dept_id,
              :dept_full_title, :dorm_full_title, :sno, :nationality, :activated,
              :direction_at_last, :status_at_last, :pass_time_at_last, :overtime_at_last, :reside,
              :role_ids, :group_ids, :name, :login, :gender_mark, :id_card, :ic_card, :tel, :face_id, :created_at, :updated_at
json.avatar_url(exchange.avatar.url)
json.dorm_parent_id(exchange.dorm.parent_id) if exchange.dorm
