class Latecomer
  include ModelBase

  field :pass_time, type: DateTime
  field :status
  field :user_name


  belongs_to :user

  set_callback(:save, :before) do |doc|
    doc.user_name = doc.user.name
  end

end