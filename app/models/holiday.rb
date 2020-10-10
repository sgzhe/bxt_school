class Holiday
  include ModelBase

  field :title, type: String, default: ''
  field :start_at, type: Date
  field :end_at, type: Date

end
