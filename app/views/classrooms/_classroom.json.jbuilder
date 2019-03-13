json.extract! classroom, :id, :title, :parent_id, :grade_mark, :desc, :created_at, :updated_at
json.department do
  json.partial! "departments/department", department: classroom.department || Department.new
end
#json.url classroom_url(classroom, format: :json)
