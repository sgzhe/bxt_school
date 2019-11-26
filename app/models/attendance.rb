class Attendance
  include ModelBase

  field :day, type: Date
  field :on_duty_time
  field :off_duty_time
  field :status, type: Symbol, default: :normal #normal :absence :late :early :late_and_early

  belongs_to :shift
  belongs_to :user
end
