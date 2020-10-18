class Tracker
  include Mongoid::Document
  include Mongoid::Timestamps
  #store_in collection: -> {"trackers#{Time.now.strftime('%Y%m')}"}

  field :pass_time, type: DateTime, default: -> {DateTime.now}
  field :direction, type: String #:in :out
  field :status, type: String, default: 'normal'
  field :reside, type: Integer, default: 0
  field :overtime, type: Integer, default: 0
  field :user_name, type: String, default: ''
  field :access_full_title, type: String, default: ''
  field :user_dept_title, type: String, default: ''
  field :user_dorm_title, type: String, default: ''
  field :user_avatar_url, type: String, default: ''
  field :user_sno, type: String, default: ''
  field :user_nationality, type: String, default: ''
  field :access_ip, type: String, default: ''
  field :face_id, type: Integer, default: 0
  field :user_org_ids, type: Array, default: []
  field :user_facility_ids, type: Array, default: []
  field :access_ids, type: Array, default: []
  field :ic_card, type: String, default: ''
  field :access_mark, type: String, default: ''

  belongs_to :access, class_name: 'Facility', required: false, validate: false
  belongs_to :user, required: false, validate: false

  mount_base64_uploader :snapshot, ImgUploader

  default_scope -> {order_by(pass_time: -1)}

  index({pass_time: -1}, {background: true})
  index({access_ids: 1}, {background: true})

  set_callback(:save, :before) do |doc|
    if doc.access
      doc.direction = doc.access.direction
      doc.access_ids = doc.access.parent_ids + [doc.access_id]
      doc.access_full_title = doc.access.full_title
    end

   if user
      doc.user_name = doc.user.try(:name)
      doc.user_sno = doc.user.try(:sno)
      doc.user_dept_title = doc.user.try(:dept_full_title)
      doc.user_dorm_title = doc.user.try(:dorm_full_title)
      doc.user_avatar_url = doc.user.try(:avatar).try(:url)
      doc.user_org_ids = doc.user.try(:org_ids)
      doc.user_facility_ids = doc.user.try(:facility_ids)
      doc.user_nationality = doc.user.try(:nationality)
      doc.user_org_ids = doc.user.try(:org_ids)
      doc.rev_status
    end

    if user.blank? || access.blank?
      doc.status = 'illegal'
    end
  end

  def rev_reside
    user ? ((pass_time - user.pass_time_at_last).to_f * 24).to_i : 0
  end

  def rev_status
    last105 = user.pass_time_at_last.at_beginning_of_day + access.closing_at.to_i.minutes
    last055 = user.pass_time_at_last.at_beginning_of_day + 1770.minutes
    today105 = pass_time.at_beginning_of_day
    today055 = pass_time.at_beginning_of_day + 330.minutes
    self.reside = rev_reside
    case direction
    when 'in'
      if last105 < pass_time && pass_time < last055
        self.status = 'back_late'
        self.overtime = ((pass_time - last105).to_f * 24).to_i
      elsif today105 < pass_time && pass_time < today055
        self.status = 'back_late'
        self.overtime = ((pass_time - last105).to_f * 24).to_i
      elsif reside >= 24
        self.status = 'days_in'
      end
    when 'out'
      if reside >= 24
        self.status = 'days_out'
      end
    end
    self.status = 'normal' unless HolidayMgr.instance.check(pass_time).blank?
  end

  set_callback(:save, :after) do |doc|
    if user
      user.update(status_at_last: doc.status,
                  pre_back_at_last: doc.pass_time.at_beginning_of_day + 1770.minutes,
                  pass_time_at_last: doc.pass_time,
                  direction_at_last: doc.direction,
                  overtime_at_last: doc.overtime,
                  access_at_last: doc.access,
                  access_ids_at_last: doc.access_ids)
      end

      if ['back_late', 'days_in', 'days_out', 'illegal'].include?(doc.status.to_s)
        comer = Latecomer.find_or_initialize_by(user: user, day: pass_time.to_date)
        comer.direction = doc.direction
        comer.status = doc.status
        comer.overtime = doc.overtime
        comer.reside = doc.reside
        comer.pass_time = doc.pass_time
        comer.access_ids = doc.access_ids
        comer.user_org_ids = doc.user.try(:org_ids)
        comer.user_facility_ids = doc.user.try(:facility_ids)
        comer.save
      end
      if user.is_a? Manager
        attendance = Attendance.find_or_initialize_by(user: doc.user, day: DateTime.now.to_date)
        attendance.access = doc.access
        attendance.save
      end

  end


end
