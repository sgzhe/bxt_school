class Chat
  include ModelBase
  field :title, type: String, default: ''

  has_many :massages
end