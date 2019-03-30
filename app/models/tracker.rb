class Tracker
  include ModelBase

  field :month, type: Date, default: -> { Date.today.at_beginning_of_month }
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []

  field :pass_time_at_last, type: DateTime
  field :status_at_last
  field :direction_at_last
  field :overtime, type: Integer, default: 0

  belongs_to :access_at_last, class_name: 'Access', foreign_key: :access_id, required: false
  belongs_to :user
  embeds_many :traces

  default_scope -> { order_by(pass_time_at_last: -1) }

  validates :user_id, uniqueness: { scope: :month, message: "should happen once per month" }

  def self.pass(user, access, direction, pass_time = DateTime.now)
    t = Tracker.find_or_initialize_by(user: user, month: pass_time.at_beginning_of_month.to_date)
    last = ((t.pass_time_at_last || DateTime.now).to_date + access.closing_at.minutes).to_datetime
    timeout = (pass_time - last).to_f
    if direction == :in
      state = :back
      state = :back_late if timeout.positive?
    else
      state = :not_back
      state = :night_out if timeout.positive?
    end

    t.status_at_last = state
    t.pass_time_at_last = pass_time
    t.direction_at_last = direction
    t.overtime = timeout.to_i if timeout.positive?
    t.traces.build(pass_time: pass_time, access: access, direction: direction)
    t.save

    if state.to_sym == :back_late
      comer = Latecomer.find_or_initialize_by(user: user, day: pass_time.to_date)
      comer.status = state
      comer.overtime = (timeout * 24).to_i
      comer.pass_time = pass_time
      comer.save
    end
  end

  def reside
    (DateTime.now - pass_time_at_last).to_i
  end

end
