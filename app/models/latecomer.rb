class Latecomer
  include ModelBase

  field :pass_time, type: DateTime
  field :day, type: Date
  field :status
  field :user_name
  field :overtime, type: Integer, default: 0
  field :overtime_cause

  belongs_to :user

  default_scope -> { order_by(pass_time: -1) }

  set_callback(:save, :before) do |doc|
    doc.user_name = doc.user.name
  end

end