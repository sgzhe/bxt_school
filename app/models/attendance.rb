class Attendance
  include ModelBase

  field :day, type: Date
  field :status
  field :updated_at, type: DateTime

  belongs_to :user
end
