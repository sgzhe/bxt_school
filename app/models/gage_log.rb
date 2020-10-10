class GageLog
  include ModelBase

  field :message, type: String, default: ''
  field :status, type: String, default: ''

  belongs_to :gate
end