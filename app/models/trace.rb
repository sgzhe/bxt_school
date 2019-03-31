class Trace
  include Mongoid::Document
  store_in collection: -> { "trackers#{Time.now.strftime('%Y%m')}" }

  field :pass_time, type: DateTime
  field :direction, type: Symbol #:in :out

  belongs_to :access
  belongs_to :tracker

  set_callback(:build, :after) do |doc|

  end
end
