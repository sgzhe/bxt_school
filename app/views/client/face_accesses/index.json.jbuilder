json.result @face_accesses, partial: 'face_accesses/face_access', as: :face_access
json.paginate_meta(paginate_meta(@face_accesses))