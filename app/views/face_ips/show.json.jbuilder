if @face_ip
  json.partial! "face_ips/face_ip", face_ip: @face_ip
end
if @face_ips
  json.array! @face_ips, partial: "face_ips/face_ip", as: :face_ip
end