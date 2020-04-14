class Guard

  def self.create(attrs)
    user = User.where('$or' => [{face_id: attrs[:face_id].to_i}, {ic_card: attrs[:ic_card]}]).first
    if attrs[:access_mark].blank?
      access = FaceAccess.where(ip: attrs[:access_ip]).first
    else
      access = CardAccess.where(ip: attrs[:access_ip], mark: attrs[:access_mark]).first
    end
    p access

    case user.class
    when Student

      tracker = Tracker.new(attrs)
      tracker.user = user
      tracker.access = access
      return tracker
    when Manager
      now = DateTime.now
      attendance = Attendance.find_or_initialize_by(user: user, day: now.to_date)
      attendance.access = access
      return attendance
    end
  end

end