class Holiday
  include ModelBase

  field :title
  field :start_at, type: Date
  field :end_at, type: Date

end
