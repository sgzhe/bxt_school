json.extract! manager, :id, :name, :gender, :id_card, :ic_card, :tel, :created_at, :updated_at
json.groups manager.groups, :id, :title, :created_at, :updated_at
json.roles manager.roles, :id, :title, :created_at, :updated_at
