class Floor
  include Mongoid::Document

  field :mark
  field :title
  field :desc

  embedded_in :house
end