class Attendance
  include Mongoid::Document

  field :day, type: Date
  field :home_state

  embedded_in :tracker
end
