class Trace
  include Mongoid::Document

  field :pass_time, type: DateTime
  field :direction, type: Symbol #:in :out

  belongs_to :gateway
  embedded_in :tracker

  set_callback(:build, :after) do |doc|

  end
end
