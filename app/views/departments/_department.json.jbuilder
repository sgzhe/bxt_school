json.extract! department, :id, :title, :parent_id, :grades, :desc, :created_at, :updated_at
json.college do
  json.partial! "colleges/college", college: department.college || College.new
end

