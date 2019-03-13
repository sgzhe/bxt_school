json.extract! group, :id, :role_ids, :title, :created_at, :updated_at
json.roles group.roles, :id, :title, :created_at, :updated_at
