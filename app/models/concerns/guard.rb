class Guard
  #@logger = Logger.new("#{Rails.root}/log/tracker.log")
  #@logger.level = Logger::DEBUG
  #@logger.info("tracker: "+ attrs.to_s)
  def self.create(attrs)
    if attrs[:access_mark].blank?
      user = User.where(face_id: attrs[:face_id].to_i).first
      access = FaceAccess.where(ip: attrs[:access_ip]).first
    else
      user = User.where(ic_card: attrs[:face_id].to_s).first
      access = CardAccess.where(ip: attrs[:access_ip], mark: attrs[:access_mark]).first
      attrs['ic_card'] = attrs.delete('face_id')
    end

    tracker = Tracker.new(attrs)
    if user.blank? || access.blank?
      tracker.status = :illegal
    else
      tracker.user = user
      tracker.access = access
    end
    return tracker
  end

end