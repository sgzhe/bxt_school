json.extract! bed, :id, :title, :parent_id, :desc, :created_at, :updated_at
json.room do
  json.partial! "rooms/room", room: bed.room || Room.new
end
