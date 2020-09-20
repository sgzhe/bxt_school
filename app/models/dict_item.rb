class DictItem
  include Mongoid::Document

  field :mark, type: String, default: ''
  field :title, type: String, default: ''
  field :desc, type: String, default: ''
  field :color, type: String, default: ''


  embedded_in :dict

end
