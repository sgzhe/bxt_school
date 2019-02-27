json.extract! floor, :id, :title, :parent_id, :created_at, :updated_at
json.house do
  json.partial! "houses/house", house: floor.house || House.new
end
