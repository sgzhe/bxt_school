class Chat
  include ModelBase
  field :title

  has_many :massages
end