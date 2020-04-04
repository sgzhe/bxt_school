json.extract! menu_item, :id, :title, :parent_id, :path, :icon, :depth, :desc, :created_at, :updated_at
json.parent_title menu_item.parent.try(:title)
#json.url menu_item_url(menu_item, format: :json)
