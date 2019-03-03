json.extract! teacher, :id, :name, :gender, :id_card, :ic_card, :tel, :created_at, :updated_at
json.department do
  json.partial! "departments/department", department: teacher.department || Department.new
end
