json.result @face_ips, partial: "face_ips/face_ip", as: :face_ip
json.paginate_meta(paginate_meta(@face_ips))