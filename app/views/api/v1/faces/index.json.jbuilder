json.result @faces, partial: "api/v1/faces/face", as: :face
json.paginate_meta(paginate_meta(@faces))