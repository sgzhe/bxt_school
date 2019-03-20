class Tracker
  include ModelBase

  field :month, type: Date, default: -> { Date.today.at_beginning_of_month }
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []
  field :pass_time_at_last, type: DateTime
  field :direction_at_last

  belongs_to :gateway_at_last, class_name: 'Gateway', foreign_key: :gateway_id, inverse_of: :classrooms, required: false
  belongs_to :user
  embeds_many :traces
  embeds_many :attendances

  validates :user_id, uniqueness: { scope: :month, message: "should happen once per month" }

  def self.pass(user, gateway, direction, time = DateTime.now)
    t = Tracker.find_or_initialize_by(user: user, month: time.at_beginning_of_month)
    t.traces.build(pass_time: time, gateway: gateway, direction: direction)
    t.save
  end

  def attendance
    if gateway_at_last.parent.is_a?(House)
      attendances.find_or_initialize_by(pass_time_at_last.at_beginning_of_day)
    end


    if doc.direction == :out
      state = 'not_back'
    else
      if doc.pass_time.hour > 22
        state = 'back_late'
      else
        state = 'back'
      end
    end
    doc.tracker.attendances

  end

  set_callback(:build, :after) do |doc|
    doc.user.room.users.each do |u|

    end
  end

end
