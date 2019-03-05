class Attendance
  include Mongoid::Document

  field :day, type: Date
  field :status

  embedded_in :tracker
end
