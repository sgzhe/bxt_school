require 'bcrypt'
class User
  include ModelBase
  include ActiveModel::SecurePassword

  attr_readonly :status, :reside

  field :name
  field :gender_mark, default: :male
  field :id_card
  field :ic_card
  field :ic_card2
  field :tel
  field :login
  field :password_digest
  field :bed_mark
  field :nationality

  field :img
  field :img2
  field :img3

  field :access_ips, type: Hash, default: {}
  field :access_status, type: Boolean, default: true

  field :pre_back_at_last, type: DateTime, default: -> { DateTime.now.at_beginning_of_day}
  field :pass_time_at_last, type: DateTime, default: -> { DateTime.now.at_beginning_of_day}
  field :status_at_last, default: :normal
  field :direction_at_last, default: :in
  field :overtime_at_last, type: Integer, default: 0
  field :access_ids_at_last, type: Array, default: []
  field :confirmed_at_last, type: Symbol, default: 'false'
  field :cause_at_last

  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []

  mount_base64_uploader :avatar, AvatarUploader

  belongs_to :access_at_last, class_name: 'Access', foreign_key: :access_id, required: false
  belongs_to :dorm, class_name: 'Room', required: false
  belongs_to :dept, class_name: 'Org', required: false
  has_and_belongs_to_many :roles, class_name: 'Role', inverse_of: nil
  has_and_belongs_to_many :groups, class_name: 'Group', inverse_of: nil
  has_many :trackers, class_name: 'Tracker', dependent: :delete_all
  has_many :latecomer, class_name: 'Latecomer', dependent: :delete_all

  delegate :full_title, to: :dept, prefix: :dept, allow_nil: true
  delegate :full_title, to: :dorm, prefix: :dorm, allow_nil: true

  scope :app, -> { where(datatype: :app) }
  #default_scope -> { order_by(id: -1) }
  #scope :reside, ->(reside) { where(:pass_time_at_last.lte => reside.days.ago) }

  #validates :sno, uniqueness: { message: "is already taken." }


  def reside
    return 0 if pass_time_at_last.nil?

    ((DateTime.now - pass_time_at_last).to_f * 24).to_i
  end

  def status
    @reside = reside
    case direction_at_last
      when :in
        @status = :days_in if @reside >= 24
      when :out
        @status = :go_out if pre_back_at_last < DateTime.now
        @status = :days_out if @reside >= 24
    end
    @status
  end

  def role?(role_mark)
    roles.any? { |role| role.mark.to_s == role_mark.to_s }
  end

  def allow?(aco_id, operation)
    return true if role?(:sys_admin)

    aros.any? do |aro|
      aro.allow?(aco_id, operation)
    end
  end

  def aros
    aro_set = roles
    groups.each do |g|
      aro_set += g
      aro_set += g.roles
    end
    aro_set
  end

  has_secure_password validations: false

  set_callback(:initialize, :before) do |doc|
    doc.password = 'bxt-123' if :new_record? && doc.password_digest.blank?
  end

  set_callback(:save, :before) do |doc|
    if doc.dorm_id_changed?
      doc.facility_ids = doc.dorm.parent_ids + [doc.dorm_id]
    end
    if doc.dept_id_changed?
      doc.org_ids += doc.dept.parent_ids + [doc.dept_id]
    end

    doc.notify_dorm
    doc.notify_face
  end

  def notify_dorm
    return unless dorm_id_changed? || bed_mark_changed?
    old_bed_mark = changes['bed_mark'][0] if bed_mark_changed?
    old_dorm_id = changes['dorm_id'][0] if dorm_id_changed?
    old_room = Room.find(old_dorm_id) if old_dorm_id
    old_bed_mark ||= bed_mark
    old_room ||= dorm
    old_room.check_out({bed_mark: old_bed_mark})
    dorm.check_in(self, bed_mark)
  end

  def notify_face
    add = nil
    if dorm_id_changed? && avatar.url
      if changes['dorm_id'][0]
        old_room = Room.find(changes['dorm_id'][0])
        Face.create(status: :delete, access_ips: old_room.house_access_ips, user: self, face_id: face_id, facility_ids: facility_ids)
      end
      if changes['dorm_id'][1]
        add = Face.create(status: :add, access_ips: dorm.house_access_ips, user: self, face_id: face_id, facility_ids: facility_ids)
      end
    end
    if avatar_changed?
      add ||= Face.create(status: :add, access_ips: dorm.house_access_ips, user: self, face_id: face_id, facility_ids: facility_ids)
    end
  end

  set_callback(:destroy, :before) do |doc|
    Face.where(:status.in => [:add, :added], user: doc).update_all(status: :delete)
    if doc.dorm
      b = doc.dorm.beds.detect { |bed| bed.mark == doc.bed_mark}
      if b
        b.owner_id = nil
        b.owner_name = nil
        doc.dorm.save
      end

    end

  end



end
