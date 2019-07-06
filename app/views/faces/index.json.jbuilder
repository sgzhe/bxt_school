json.result @faces, partial: "faces/face", as: :face
json.paginate_meta(paginate_meta(@faces))