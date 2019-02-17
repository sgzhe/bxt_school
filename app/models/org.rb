class Org
  include ModelBase
  include Mongoid::Tree

  field :title

  default_scope -> { order_by(id: -1)}
end
