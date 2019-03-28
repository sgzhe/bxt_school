class Latecomer
  include ModelBase

  field :pass_time, type: DateTime
  field :day, type: Date
  field :status
  field :user_name
  field :overtime, type: Integer, default: 0

  belongs_to :user

  set_callback(:save, :before) do |doc|
    doc.user_name = doc.user.name
  end

end