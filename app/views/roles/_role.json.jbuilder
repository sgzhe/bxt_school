json.extract! role, :id, :group_ids, :title, :created_at, :updated_at
json.groups role.groups, :id, :title, :created_at, :updated_at
