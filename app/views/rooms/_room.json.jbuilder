json.extract! room, :id, :title, :parent_id, :floor_mark, :owner_id, :total_beds, :vacant_beds, :desc, :created_at, :updated_at
json.house do
  json.partial! "houses/house", house: room.house || House.new
end
json.floor room.floor, :id, :title, :desc
json.beds room.beds, :id, :bed_no, :title, :owner_id, :owner_name