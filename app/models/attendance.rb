class Attendance
  include ModelBase

  field :day, type: Date
  field :status

  belongs_to :user
end
