json.extract! room, :id, :title, :parent_id, :floor_mark, :created_at, :updated_at
json.house do
  json.partial! "houses/house", house: room.house || House.new
end
json.floor room.floor, :id, :title, :desc