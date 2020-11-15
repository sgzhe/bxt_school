require 'bcrypt'
class User
  include ModelBase
  include ActiveModel::SecurePassword

  attr_readonly :status, :reside

  field :name, type: String, default: ''
  field :gender_mark, type: String, default: :male
  field :id_card, type: String, default: ''
  field :ic_card, type: String, default: ''
  field :ic_card2
  field :tel, type: String, default: ''
  field :login, type: String, default: ''
  field :password_digest, type: String, default: ''
  field :bed_mark, type: String, default: ''
  field :nationality, type: String, default: ''
  field :nation, type: String, default: ''
  field :birthday, type: Date
  field :hometown, type: String, default: ''
  field :cls_group, type: String, default: ''

  field :img
  field :img2
  field :img3

  field :access_ips, type: Hash, default: {}
  field :access_status, type: Boolean, default: true
  field :card_access_ips, type: Hash, default: {}
  field :card_access_status, type: Boolean, default: true

  field :pre_back_at_last, type: DateTime, default: -> {DateTime.now.at_beginning_of_day}
  field :pass_time_at_last, type: DateTime, default: -> {DateTime.now.at_beginning_of_day}
  field :status_at_last, type: String, default: :normal
  field :direction_at_last, type: String, default: ''
  field :overtime_at_last, type: Integer, default: 0
  field :access_ids_at_last, type: Array, default: []
  field :confirmed_at_last, type: String, default: 'false'
  field :cause_at_last, type: String, default: ''
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
    dept.try(:full_title)
  end

  def dorm_full_title
    dorm.try(:full_title)
  end

  scope :app, -> {where(datatype: :app)}
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
    when 'in'
      @status = :days_in if @reside >= 24
    when 'out'
      @status = :days_out if @reside >= 24
      @status = :go_out if pre_back_at_last < DateTime.now
    end
    @status
  end

  def role?(role_mark)
    roles.any? {|role| role.mark.to_s == role_mark.to_s}
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
    if doc.dept_id_changed?
      doc.org_ids += doc.dept.parent_ids + [doc.dept_id]
    end
<<<<<<< HEAD

=======
>>>>>>> a51ded2da88ff1d705968d299c62bb26eee4670c
    if doc.dorm
      if doc.dorm_id_changed?
        doc.facility_ids = doc.dorm.parent_ids + [doc.dorm_id]
      end
      doc.notify_dorm
      doc.notify_face
    end
  end

  def notify_dorm
    if dorm_id_changed?
      old_room = Room.where(id: changes['dorm_id'][0]).first
      old_room.check_out({user_id: self.id}) if old_room
    elsif bed_mark_changed?
      dorm.check_out({bed_mark: changes['bed_mark'][0]})
    end
    dorm.check_in(self, bed_mark)
  end

  def notify_face
    add = nil
    bbb = nil
    if dorm_id_changed?
      if changes['dorm_id'][0]
        old_room = Room.find(changes['dorm_id'][0])
        if old_room.parent_id != dorm.parent_id
          unless avatar.url.blank?
            FaceIp.factory({house: HouseMgr.find(old_room.parent_ids), user: self, operation: 'delete'})
            FaceIp.factory({house: HouseMgr.find(dorm.parent_ids), user: self, operation: 'add'})
            add = true
          end
          unless ic_card.blank?
            CardIp.factory({house: HouseMgr.find(old_room.parent_ids), user: self, operation: 'delete'})
            CardIp.factory({house: HouseMgr.find(dorm.parent_ids), user: self, operation: 'add'})
            bbb = true
          end
        end
      end
    end
    if avatar_changed?
      add ||= FaceIp.factory({house:  HouseMgr.find(dorm.parent_ids), user: self, operation: 'add'})
    end
    if ic_card_changed?
      unless changes['ic_card'][0].blank?
        CardIp.factory({house: HouseMgr.find(dorm.parent_ids), user: self, operation: 'delete', access_no: self.changes['ic_card'][0]})
      end
      unless changes['ic_card'][1].blank?
        bbb ||= CardIp.factory({house: HouseMgr.find(dorm.parent_ids), user: self, operation: 'add', access_no: self.changes['ic_card'][1]})
      end
    end
  end


  def notify_face3
    add = nil
    bbb = nil
    if dorm_id_changed?
      if changes['dorm_id'][0]
        old_room = Room.find(changes['dorm_id'][0])
        if old_room.parent_id != dorm.parent_id
          unless avatar.url.blank?
            send_face(:delete, HouseMgr.find(old_room.parent_ids).try(:access_ips))
            send_face(:add, HouseMgr.find(dorm.parent_ids).try(:access_ips))
            add = true
          end
          unless ic_card.blank?
            send_card(:delete, HouseMgr.find(old_room.parent_ids).try(:card_access_ips))
            send_card(:add, HouseMgr.find(dorm.parent_ids).try(:card_access_ips))
            bbb = true
          end
        end
      end
    end
    if avatar_changed?
      add ||= send_face(:add, HouseMgr.find(dorm.parent_ids).try(:access_ips))
    end
    if ic_card_changed?
      unless changes['ic_card'][0].blank?
        Card.create(status: :delete, card_access_ips: HouseMgr.find(dorm.parent_ids).try(:card_access_ips), user: self, ic_card: self.changes['ic_card'][0], facility_ids: self.facility_ids, house: self.house)
      end
      unless changes['ic_card'][1].blank?
        bbb ||= Card.create(status: :add, card_access_ips: HouseMgr.find(dorm.parent_ids).try(:card_access_ips), user: self, ic_card: self.changes['ic_card'][1], facility_ids: self.facility_ids, house: self.house)
      end
    end
  end

  def send_face(status = :add, access_ips = {})
    Face.create(status: status, access_ips: access_ips, user: self, face_id: face_id, facility_ids: facility_ids)
  end

  def send_card(status = :add, card_access_ips = {})
    Card.create(status: status, card_access_ips: card_access_ips, user: self, ic_card: self.ic_card, facility_ids: self.facility_ids, house: self.house)
  end

  set_callback(:destroy, :before) do |doc|
    if doc.dorm
      doc.dorm.check_out(user_id: doc.id)
    end
    #FaceIp.where(status: 'added', user: doc).update_all(status: :delete)
    #FaceIp.where(:status.in => ['deleted', 'add'], user: doc).delete_all
    #CardIp.where(status: 'added', user: doc).update_all(status: :delete)
    #CardIp.where(:status.in => ['deleted', 'add'], user: doc).delete_all

    #Face.where(status: :deleted).delete_all
    #Face.where(:status.in => [:add, :added], user: doc).update_all(status: :delete)
    #Card.where(status: :deleted).delete_all
    #Card.where(:status.in => [:add, :added], user: doc).update_all(status: :delete)
  end

end
