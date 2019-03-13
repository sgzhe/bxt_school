json.extract! teacher, :id, :org_id, :facility_id, :role_ids, :group_ids, :name, :gender_mark, :id_card, :ic_card, :tel, :created_at, :updated_at
json.department do
  json.partial! "departments/department", department: teacher.department || Department.new
end
json.groups teacher.groups, :id, :title, :created_at, :updated_at
json.roles teacher.roles, :id, :title, :created_at, :updated_at
