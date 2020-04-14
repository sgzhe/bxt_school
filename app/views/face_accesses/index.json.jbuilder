json.result @face_accesses, partial: 'face_accesses/access', as: :face_access
json.paginate_meta(paginate_meta(@face_accesses))