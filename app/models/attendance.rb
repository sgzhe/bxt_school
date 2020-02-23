class Attendance
  include ModelBase

  field :day, type: Date
  field :on_duty_time, type: DateTime
  field :off_duty_time, type: DateTime
  field :status, type: Symbol, default: :normal #normal :absence :late :early :late_and_early
  field :user_name
  field :access_title
  field :access_ids, type: Array

  belongs_to :shift, required: false
  belongs_to :user
  belongs_to :access

  set_callback(:save, :before) do |doc|
    now = DateTime.now
    if doc.on_duty_time.blank?
      doc.on_duty_time = now
      doc.status = :normal
    else
      doc.off_duty_time = now
    end
    doc.user_name = doc.user.name
    doc.access_title = doc.access.full_title
    doc.access_ids = doc.access.parent_ids + [access.id]
  end
end
