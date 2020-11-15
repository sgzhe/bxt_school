class Guard
  @logger = Logger.new("#{Rails.root}/log/tracker.log")
  @logger.level = Logger::DEBUG

  def self.create(attrs)
    if attrs[:access_mark].blank? &&  attrs[:face_id].size < 10
      user = User.where(face_id: attrs[:face_id].to_i).first
      access = FaceAccess.where(ip: attrs[:access_ip]).first
    else
      user = User.where(ic_card: attrs[:face_id].to_s).first
      access = CardAccess.where(ip: attrs[:access_ip], mark: attrs[:access_mark]).first
      attrs[:ic_card] = attrs[:face_id]
    end

    tracker = Tracker.new(attrs)
    if user.present? && access.present?
      tracker.user = user
      tracker.access = access
    end
    unless tracker.valid?
      @logger.info("tracker: "+ attrs.to_s)
      @logger.info("user:" + user.to_json(:only => [:_id, :name]))
      @logger.info("access:" + access.to_json(:only => [:_id, :title]))
    end
    return tracker
  end

end