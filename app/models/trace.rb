class Trace
  include Mongoid::Document

  field :exit_time, type: DateTime
  field :entry, type: DateTime

  belongs_to :facility
  embedded_in :tracker
end
