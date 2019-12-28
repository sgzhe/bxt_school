json.result @faces, partial: "client/faces/face", as: :face
json.paginate_meta(paginate_meta(@faces))