json.extract! role, :id, :group_ids, :title, :desc, :created_at, :updated_at
json.groups role.groups, :id, :title, :role_ids, :desc, :created_at, :updated_at
