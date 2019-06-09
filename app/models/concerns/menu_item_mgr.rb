class MenuItemMgr
  include ::Singleton

  def initialize
    load
  end

  def load
    @menu_items = MenuItem.all.to_a
  end

  alias reload load

  def find(id)
    @menu_items.find { |item| item.id.to_s == id.to_s }
  end

  def find_by_parent(parent_id)
    @menu_items.select { |item| item.parent_id.to_s == parent_id.to_s }
  end

  def traverse(parent_id = nil)
    result = []
    find_by_parent(parent_id).each do |item|
      result << item
      result << find_by_parent(item.id)
    end
    result.flatten
  end
end