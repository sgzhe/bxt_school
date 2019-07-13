json.extract! manager, :id, :role_ids, :group_ids, :name, :login, :gender_mark, :id_card, :ic_card, :tel, :created_at, :updated_at
json.groups manager.groups, :id, :title, :created_at, :updated_at
json.roles manager.roles, :id, :title, :created_at, :updated_at
