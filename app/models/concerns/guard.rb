class Guard
  @logger = Logger.new("#{Rails.root}/log/tracker.log")
  @logger.level = Logger::DEBUG

  def self.create(attrs)
    #users = User.and('$or' => [{}, {ic_card: attrs[:face_id].to_s}])
    #user = users.first if users.size == 1
    @logger.info("tracker: "+ attrs.to_s)
    if attrs[:access_mark].blank?
      user = User.where(face_id: attrs[:face_id].to_i).first
      access = FaceAccess.where(ip: attrs[:access_ip]).first
    else
      user = User.where(ic_card: attrs[:face_id].to_s).first
      access = CardAccess.where(ip: attrs[:access_ip], mark: attrs[:access_mark]).first
      attrs['ic_card'] = attrs.delete('face_id')
    end

    tracker = Tracker.new(attrs)
    tracker.user = user
    tracker.status = :illegal unless user
    tracker.access = access
    return tracker
  end

end