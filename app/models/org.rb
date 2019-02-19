class Org
  include ModelBase
  include Mongoid::Tree
  include Mongoid::Tree::Traversal

  field :title

  default_scope -> { order_by(id: -1)}
end
