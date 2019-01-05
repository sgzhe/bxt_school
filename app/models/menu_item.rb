class MenuItem
  include ModelBase
  include Mongoid::Tree

  field :title
  field :path
  field :icon

end
