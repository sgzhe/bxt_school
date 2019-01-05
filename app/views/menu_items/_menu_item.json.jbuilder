json.extract! menu_item, :id, :title, :path, :icon, :depth
json.id(menu_item.id.to_s)
json.parent_id(menu_item.parent_id.to_s)
#json.url menu_item_url(menu_item, format: :json)
