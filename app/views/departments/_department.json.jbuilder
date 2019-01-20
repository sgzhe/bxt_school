json.extract! department, :id, :title, :parent_id, :desc, :created_at, :updated_at
json.college do
  json.partial! "colleges/college", college: department.college || Department.new
end
#json.college department.college, :id, :title
#json.url department_path(department, format: :json)
