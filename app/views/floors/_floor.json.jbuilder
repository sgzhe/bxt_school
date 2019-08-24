json.extract! floor, :id, :title, :full_title, :parent_id, :desc, :mark, :created_at, :updated_at
json.house do
  json.partial! "houses/house", house: floor.house || House.new
end