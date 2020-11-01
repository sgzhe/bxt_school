json.result @client_face_ips, partial: "client/face_ips/client_face_ip", as: :client_face_ip
json.paginate_meta(paginate_meta(@client_face_ips))