class Tracker
  include ModelBase

  field :month, type: Date, default: -> {Date.today.at_beginning_of_month}
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []

  belongs_to :user
  embeds_many :traces

  validates :user_id, uniqueness: {scope: :month, message: "should happen once per month"}

  def self.pass(user, gateway, direction, pass_time = Time.now)
    t = Tracker.find_or_initialize_by(user: user, month: pass_time.at_beginning_of_month)
    t.traces.build(pass_time: pass_time, gateway: gateway, direction: direction)
    t.checking_attendance(pass_time, direction) if gateway.parent_id == user.room.parent_id
    t.save
  end

  def checking_attendance(pass_time, direction)
    at = attendances.find_or_initialize_by(day: pass_time.at_beginning_of_day)
    if direction.to_sym == :out
      at.status = :not_back
    else
      if pass_time.hour > 22
        at.status = :back_late
      else
        at.status = :back
      end
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
