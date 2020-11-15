json.extract! face, :id, :face_id, :access_ips, :status, :user_id, :counts, :created_at, :updated_at
if face.user
  json.face_url(face.user.avatar.url)
  json.user_name(face.user.name)
end
