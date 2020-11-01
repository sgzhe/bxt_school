if @client_face_ip
  json.partial! "client/face_ips/client_face_ip", client_face_ip: @client_face_ip
end
if @client_face_ips
  json.array! @client_face_ips, partial: "client/face_ips/client_face_ip", as: :client_face_ip
end