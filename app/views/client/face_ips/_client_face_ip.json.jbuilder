json.extract! client_face_ip, :id, :access_no, :access_ip, :user_id, :house_id, :operation, :status, :errno, :created_at, :updated_at
if client_face_ip.user
  json.user_name(client_face_ip.user.name)
  json.face_url(client_face_ip.user.avatar.blank? ?  '' : (base_url + client_face_ip.user.avatar.url.to_s))
end