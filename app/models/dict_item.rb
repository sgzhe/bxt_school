class DictItem
  include Mongoid::Document

  field :name
  field :title
  field :desc

  embedded_in :dict

end
