class Trace
  include Mongoid::Document

  field :pass_time, type: DateTime
  field :direction, type: Symbol #:in :out

  belongs_to :facility
  embedded_in :tracker
end
