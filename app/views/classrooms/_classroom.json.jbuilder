json.extract! classroom, :id, :title, :parent_id, :desc, :created_at, :updated_at
json.grade do
  json.partial! "grades/grade", grade: classroom.grade || Grade.new
end
#json.url classroom_url(classroom, format: :json)
