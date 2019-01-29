json.extract! grade, :id, :parent_id, :title, :desc, :created_at, :updated_at
json.department do
  json.partial! "departments/department", department: grade.department || Department.new
end
#json.url grade_url(grade, format: :json)
