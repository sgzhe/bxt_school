json.extract! room, :id, :title, :parent_id, :floor_mark, :floor, :created_at, :updated_at
json.house do
  json.partial! "houses/house", house: room.house || House.new
end