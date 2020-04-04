class MenuItem
  include ModelBase
  include Mongoid::Tree
  include Mongoid::Tree::Traversal

  field :title
  field :path
  field :icon

  has_many :permissions, as: :aco, class_name: 'Permission'

  set_callback(:save, :after) do |doc|
    MenuItemMgr.instance.reload
  end

  set_callback(:destroy, :after) do |doc|
    MenuItemMgr.instance.reload
  end

end
