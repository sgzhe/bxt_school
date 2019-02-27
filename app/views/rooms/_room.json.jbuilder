json.extract! room, :id, :title, :parent_id, :created_at, :updated_at
#json.url room_url(room, format: :json)
json.floor do
  json.partial! "floors/floor", floor: room.floor || Floor.new
end