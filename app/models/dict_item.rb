class DictItem
  include Mongoid::Document

  field :mark
  field :title
  field :desc
  field :color


  embedded_in :dict

end
