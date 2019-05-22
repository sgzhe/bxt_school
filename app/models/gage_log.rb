class GageLog
  include ModelBase

  field :message
  field :status

  belongs_to :gate
end