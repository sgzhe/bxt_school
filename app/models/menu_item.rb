class MenuItem
  include ModelBase
  include Mongoid::Tree
  include Mongoid::Tree::Traversal

  field :title
  field :path
  field :icon

end
