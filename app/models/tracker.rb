class Tracker
  include Mongoid::Document
  store_in collection: -> { "trackers#{Time.now.strftime('%Y%m')}" }

  field :pass_time, type: DateTime
  field :direction, type: Symbol #:in :out
  field :status
  field :overtime, type: Integer, default: 0

  belongs_to :access
  belongs_to :user

  default_scope -> { order_by(pass_time: -1) }


end
