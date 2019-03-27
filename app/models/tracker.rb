class Tracker
  include ModelBase

  field :month, type: Date, default: -> { Date.today.at_beginning_of_month }
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []
  field :overtime_cause
  field :pass_time_at_last, type: DateTime

  belongs_to :user
  embeds_many :traces

  validates :user_id, uniqueness: {scope: :month, message: "should happen once per month"}

  def self.pass(user, access, direction, pass_time = Time.now)
    t = Tracker.find_or_initialize_by(user: user, month: pass_time.at_beginning_of_month)
    t.traces.build(pass_time: pass_time, access: access, direction: direction)
    t.checking(pass_time, direction) if access.parent_id == user.room.parent_id
    t.save
  end

  def checking(pass_time, direction)
    h = Time.new(pass_time.year, pass_time.month, pass_time.day, 10, 30)
    if (pass_time > h) && (direction == :in)
      comer = Latecomer.find_or_initialize_by(user_id: user_id, day: pass_time.to_date, updated_at: pass_time)
      comer.status = :back_late
      comer.save
    end
  end

  def get_attendance(day)
    attendances.detect { |a| a.day.day == day }
  end

  set_callback(:build, :after) do |doc|
    doc.user.room.users.each do |u|

    end
  end

end
