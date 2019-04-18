class Tracker
  include Mongoid::Document
  store_in collection: -> { "trackers#{Time.now.strftime('%Y%m')}" }

  field :pass_time, type: DateTime, default: -> { DateTime.now }
  field :direction, type: Symbol #:in :out
  field :status
  field :timed_out, type: Boolean
  field :overtime, type: Integer, default: 0

  belongs_to :access
  belongs_to :user

  default_scope -> { order_by(pass_time: -1) }

  set_callback(:save, :before) do |doc|
    last = (user.pass_time_at_last.at_beginning_of_day + access.closing_at.minutes)
    today = (pass_time.at_beginning_of_day + access.opening_at.minutes)
    self.timed_out = pass_time > last
    self.overtime = timed_out ? ((pass_time - last).to_f * 24).to_i : 0
    if direction == :in
      self.status = self.timed_out ? :back_late : :back
    else
      self.status = self.timed_out && (pass_time < today) ? :night_out : :go_out
    end
  end

  set_callback(:save, :after) do |doc|
    doc.user.status_at_last = doc.status
    doc.user.pass_time_at_last = doc.pass_time
    doc.user.direction_at_last = doc.direction
    doc.user.overtime_at_last = doc.overtime
    doc.user.access_at_last = doc.access
    doc.user.save

    if doc.timed_out
      comer = Latecomer.find_or_initialize_by(user: user, day: pass_time.to_date)
      comer.status = doc.status
      comer.overtime = doc.overtime
      comer.pass_time = doc.pass_time
      comer.save
    end
  end

end
