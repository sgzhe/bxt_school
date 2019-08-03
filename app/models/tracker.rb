class Tracker
  include Mongoid::Document
  include Mongoid::Timestamps
  #store_in collection: -> {"trackers#{Time.now.strftime('%Y%m')}"}

  field :pass_time, type: DateTime, default: -> {DateTime.now}
  field :direction, type: Symbol #:in :out
  field :status, type: Symbol
  field :reside, type: Integer, default: 0
  field :overtime, type: Integer, default: 0
  field :user_name
  field :user_dept_title
  field :user_dorm_title
  field :user_avatar_url
  field :user_sno
  field :access_ip
  field :face_id, type: Integer, default: 0
  field :user_org_ids, type: Array, default: []
  field :user_facility_ids, type: Array, default: []
  field :access_ids, type: Array, default: []

  belongs_to :access, required: false
  belongs_to :user, required: false

  mount_base64_uploader :snapshot, ImgUploader

  default_scope -> { order_by(pass_time: -1) }

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
    end
  end

  set_callback(:save, :before) do |doc|
    last105 = (user.pass_time_at_last.at_beginning_of_day + access.closing_at.minutes)
    today = (pass_time.at_beginning_of_day + access.opening_at.minutes)
    if direction == :in
      if pass_time > last105
        if user.reside >= 24
          self.status = user.status
          self.reside = user.reside
        else
          self.overtime = ((pass_time - last105).to_f * 24).to_i
          self.status = :back_late
        end
      end
    else
      if user.reside >= 24
        self.status = user.status
        self.reside = user.reside

      end
    end
    doc.user_name = doc.user.name
    doc.user_sno = doc.user.sno
    doc.user_dept_title = doc.user.dept_full_title
    doc.user_dorm_title = doc.user.dorm_full_title
    doc.user_avatar_url = doc.user.avatar.url
    doc.user_org_ids = doc.user.org_ids
    doc.user_facility_ids = doc.user.facility_ids
  end

  set_callback(:save, :after) do |doc|
    user.update(status_at_last: doc.status,
                pre_back_at_last: doc.pass_time.at_beginning_of_day + 1770.minutes,
                pass_time_at_last: doc.pass_time,
                direction_at_last: doc.direction,
                overtime_at_last: doc.overtime,
                access_at_last: doc.access,
                access_ids_at_last: doc.access_ids)

    if [:back_late, :go_out, :days_in, :days_out].include?(doc.status.try(:to_sym))
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

end
