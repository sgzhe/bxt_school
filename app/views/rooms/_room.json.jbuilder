json.extract! room, :id, :title, :full_title, :parent_id, :owner_id, :total_beds, :vacant_beds,
              :dorm_type, :dorm_toward, :desc, :created_at, :updated_at
json.beds room.beds, :id, :mark, :owner_id, :owner_name
# json.floor do
#   json.partial! "floors/floor", floor: room.floor || Floor.new
# end