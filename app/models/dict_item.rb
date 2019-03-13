class DictItem
  include Mongoid::Document

  field :mark
  field :title
  field :desc

  embedded_in :dict

end
