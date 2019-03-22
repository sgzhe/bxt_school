class Attendance
  include Mongoid::Document

  field :day, type: Date
  field :status
  field :updated_at, type: DateTime

  embedded_in :tracker
end
