class Attendance
  include ModelBase

  field :day, type: Date
  field :on_duty_time, type: DateTime
  field :off_duty_time, type: DateTime
  field :status, type: String, default: :normal #normal :absence :late :early :late_and_early
  field :user_name, type: String, default: ''
  field :access_title, type: String, default: ''
  field :access_ids, type: Array
  field :pass_time, type: DateTime, default: -> {DateTime.now}

  belongs_to :shift, required: false
  belongs_to :user
  belongs_to :access, required: false

  set_callback(:save, :before) do |doc|
    now = DateTime.now
    if doc.on_duty_time.blank?
      doc.on_duty_time = now
      doc.status = :normal
    else
      doc.off_duty_time = now
    end
    doc.user_name = doc.user.name
    if doc.access
      doc.access_title = doc.access.try(:full_title)
      doc.access_ids = doc.access.try(:parent_ids) + [access.try(:id)]
    end

  end
end
