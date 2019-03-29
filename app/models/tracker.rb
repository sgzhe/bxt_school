class Tracker
  include ModelBase

  field :month, type: Date, default: -> { Date.today.at_beginning_of_month }
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []
  field :overtime_cause_at_last
  field :pass_time_at_last, type: DateTime
  field :status_at_last
  field :direction_at_last

  belongs_to :access_at_last, class_name: 'Access', foreign_key: :access_id
  belongs_to :user
  embeds_many :traces

  validates :user_id, uniqueness: { scope: :month, message: "should happen once per month" }

  def self.pass(user, access, direction, pass_time = Time.now)
    t = Tracker.find_or_initialize_by(user: user, month: pass_time.at_beginning_of_month.to_date)
    t.access_at_last = access
    t.pass_time_at_last = pass_time
    t.direction_at_last = direction
    t.resolve
    t.traces.build(pass_time: pass_time, access: access, direction: direction)
    t.save
    if t.status_at_last.to_sym == :back_late
      comer = Latecomer.find_or_initialize_by(user: user, day: pass_time.to_date)
      comer.status = t.status_at_last
      comer.overtime = t.overtime
      comer.pass_time = pass_time
      comer.save
    end
  end

  def resolve
    ot = overtime
    if direction_at_last == :in
      self.status_at_last = :back
      self.status_at_last = :back_late if ot.positive?
    else
      self.status_at_last = :not_back
      self.status_at_last = :night_out if ot.positive?
    end
  end

  def overtime
    t = pass_time_at_last.hour * 60
    t += pass_time_at_last.minute
    t - access_at_last.closing_at
  end

  def get_attendance(day)
    attendances.detect { |a| a.day.day == day }
  end

  set_callback(:build, :after) do |doc|

  end

end
