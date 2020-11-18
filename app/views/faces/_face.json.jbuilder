json.extract! face, :id, :face_id, :access_ips, :status, :user_id, :counts, :created_at, :updated_at
json.face_url(face.user_avatar_url.present? ? base_url + face.user_avatar_url : '')
json.user_name(face.user_name.present? ? face.user_name : face.user.try(:name) || '')
