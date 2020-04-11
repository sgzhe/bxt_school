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
  field :nation
  field :birthday, type: Date
  field :hometown
  field :cls_group

  field :img
  field :img2
  field :img3

  field :access_ips, type: Hash, default: {}
  field :access_status, type: Boolean, default: true
  field :card_access_ips, type: Hash, default: {}
  field :card_access_status, type: Boolean, default: true

  field :pre_back_at_last, type: DateTime, default: -> { DateTime.now.at_beginning_of_day}
  field :pass_time_at_last, type: DateTime, default: -> { DateTime.now.at_beginning_of_day}
  field :status_at_last, default: :normal
  field :direction_at_last, default: :in
  field :overtime_at_last, type: Integer, default: 0
  field :access_ids_at_last, type: Array, default: []
  field :confirmed_at_last, type: Symbol, default: 'false'
  field :cause_at_last
  field :face_id, type: Integer, default: 0

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
  has_and_belongs_to_many :chats, inverse_of: nil

  def dept_full_title
    dept.full_title
  end

  def dorm_full_title
    dorm.full_title
  end

  scope :app, -> { where(datatype: :app) }
  #default_scope -> { order_by(id: -1) }
  #scope :reside, ->(reside) { where(:pass_time_at_last.lte => reside.days.ago) }

  #validates :sno, uniqueness: { message: "is already taken." }

  def house
    @house ||= HouseMgr.instance.find(facility_ids)
  end

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
        if old_room.parent_id != dorm.parent_id
          send_face(:delete, HouseMgr.instance.find(old_room.parent_id).try(:access_ips))
          send_face(:add, HouseMgr.instance.find(dorm.parent_id).try(:access_ips))
          send_card(:delete, HouseMgr.instance.find(old_room.parent_id).try(:card_access_ips))
          send_card(:add, HouseMgr.instance.find(dorm.parent_id).try(:card_access_ips))
          add = true
        end
      end
    end
    if avatar_changed?
      add ||= send_face(:add, HouseMgr.instance.find(dorm.parent_id).try(:access_ips))
    end
    if activated == false
      doc.dorm && doc.dorm.check_out(user_id: doc.id, bed_mark: doc.bed_mark)
      Face.where(:status.in => [:add, :added], user: doc).update_all(status: :delete)
      Card.where(:status.in => [:add, :added], user: doc).update_all(status: :delete)
    end
  end

  def send_face(status = :add, access_ips = {})
    Face.create(status: status, access_ips: access_ips, user: self, face_id: face_id, facility_ids: facility_ids)
  end

  def send_card(status = :add, card_access_ips = {})
    Card.create(status: status, card_access_ips: card_access_ips, user: self, id_card: self.id_card, facility_ids: self.facility_ids, house: self.house)
  end

  set_callback(:destroy, :before) do |doc|
    doc.dorm && doc.dorm.check_out(user_id: doc.id, bed_mark: doc.bed_mark)
    Face.where(:status.in => [:add, :added], user: doc).update_all(status: :delete)
    Card.where(:status.in => [:add, :added], user: doc).update_all(status: :delete)
  end

end
