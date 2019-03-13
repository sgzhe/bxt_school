json.extract! manager, :id, :org_id, :facility_id, :role_ids, :group_ids, :name, :gender_mark, :id_card, :ic_card, :tel, :created_at, :updated_at
json.groups manager.groups, :id, :title, :created_at, :updated_at
json.roles manager.roles, :id, :title, :created_at, :updated_at
