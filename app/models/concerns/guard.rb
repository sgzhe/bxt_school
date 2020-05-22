class Guard

  def self.create(attrs)
    p attrs
    user = User.and('$or' => [{face_id: attrs[:face_id].to_i}, {ic_card: attrs[:face_id].to_s}]).first
    if attrs[:access_mark].blank?
      access = FaceAccess.where(ip: attrs[:access_ip]).first
    else
      access = CardAccess.where(ip: attrs[:access_ip], mark: attrs[:access_mark]).first
    end

    tracker = Tracker.new(attrs)
    tracker.user = user
    tracker.status = :illegal unless user
    tracker.access = access
    return tracker
  end

end