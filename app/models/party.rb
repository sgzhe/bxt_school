class Party
  include ModelBase
  include Mongoid::Tree

  field :title
end
