class Tracker
  include Mongoid::Document
  include Mongoid::Timestamps
  #store_in collection: -> {"trackers#{Time.now.strftime('%Y%m')}"}

  field :pass_time, type: DateTime, default: -> {DateTime.now}
  field :direction, type: Symbol #:in :out
  field :status, type: Symbol, default: :normal
  field :reside, type: Integer, default: 0
  field :overtime, type: Integer, default: 0
  field :user_name
  field :access_full_title
  field :user_dept_title
  field :user_dorm_title
  field :user_avatar_url
  field :user_sno
  field :user_nationality
  field :access_ip
  field :face_id, type: Integer, default: 0
  field :user_org_ids, type: Array, default: []
  field :user_facility_ids, type: Array, default: []
  field :access_ids, type: Array, default: []

  belongs_to :access, required: false
  belongs_to :user, required: false

  mount_base64_uploader :snapshot, ImgUploader

  default_scope -> { order_by(pass_time: -1) }

  index({ pass_time: -1 }, { background: true })
  index({ user_org_ids: 1 }, { background: true })

  set_callback(:initialize, :after) do |doc|
    doc.user ||= User.find_by(face_id: doc.face_id.to_i)
    if doc.user
      doc.user_org_ids = doc.user.org_ids
      doc.user_facility_ids = doc.user.facility_ids
    end
    doc.access ||= Access.find_by(ip: doc.access_ip)
    if doc.access
      doc.direction = doc.access.direction
      doc.access_ids = doc.access.parent_ids + [doc.access_id]
      doc.access_full_title = doc.access.full_title
    end
  end

  set_callback(:save, :before) do |doc|
    if doc.is_a?(Student)
      doc.rev_status
      doc.user_name = doc.user.name
      doc.user_sno = doc.user.sno
      doc.user_dept_title = doc.user.dept_full_title
      doc.user_dorm_title = doc.user.dorm_full_title
      doc.user_avatar_url = doc.user.avatar.url
      doc.user_org_ids = doc.user.org_ids
      doc.user_facility_ids = doc.user.facility_ids
      doc.user_nationality = doc.user.nationality
    end
  end

  def rev_reside
    ((pass_time - user.pass_time_at_last).to_f * 24).to_i
  end

  def rev_status
    last105 = user.pass_time_at_last.at_beginning_of_day + access.closing_at.minutes
    last055 = user.pass_time_at_last.at_beginning_of_day + 1770.minutes
    today105 = pass_time.at_beginning_of_day
    today055 = pass_time.at_beginning_of_day + 330.minutes
    self.reside = rev_reside
    case direction
    when :in
      if last105 < pass_time && pass_time < last055
        self.status = :back_late
        self.overtime = ((pass_time - last105).to_f * 24).to_i
      elsif today105 < pass_time && pass_time < today055
        self.status = :back_late
        self.overtime = ((pass_time - last105).to_f * 24).to_i
      elsif reside >= 24
        self.status = :days_out
      end
    when :out
      if reside >= 24
        self.status = :days_in
      end
    end
    self.status = :normal unless HolidayMgr.instance.check(pass_time).blank?
  end

  set_callback(:save, :after) do |doc|
    user.update(status_at_last: doc.status,
                pre_back_at_last: doc.pass_time.at_beginning_of_day + 1770.minutes,
                pass_time_at_last: doc.pass_time,
                direction_at_last: doc.direction,
                overtime_at_last: doc.overtime,
                access_at_last: doc.access,
                access_ids_at_last: doc.access_ids)

    if [:back_late, :days_in, :days_out].include?(doc.status.try(:to_sym))
      comer = Latecomer.find_or_initialize_by(user: user, day: pass_time.to_date)
      comer.direction = doc.direction
      comer.status = doc.status
      comer.overtime = doc.overtime
      comer.reside = doc.reside
      comer.pass_time = doc.pass_time
      comer.access_ids = doc.access_ids
      comer.user_org_ids = doc.user.org_ids
      comer.user_facility_ids = doc.user.facility_ids
      comer.save
    end
  end

  set_callback(:save, :after) do |doc|
    unless doc.user.is_a?(Student)
      now = DateTime.now
      attendance = Attendance.find_or_initialize_by(user: doc.user, day: now.to_date)
      p 'sgz-------------'
      attendance.access = doc.access
      p attendance.errors
      p attendance.save

    end
  end

end
