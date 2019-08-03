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

  field :img
  field :img2

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
  def house_access_ips
    Access.where(:parent_id.in => self.facility_ids).map(&:ip).delete_if { |k| k.blank? }
  end

  def reside
    return 0 if pass_time_at_last.nil?

    ((DateTime.now - pass_time_at_last).to_f * 24).to_i
  end

  def status
    #@status = status_at_last    
    if reside >= 24
      case direction_at_last
      when :in
        @status = :days_in
      when :out
        @status = :days_out
      end
    else
      case direction_at_last
      when :in

      when :out
        @status = :go_out if pre_back_at_last < DateTime.now
      end
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
    doc.notify_face
    doc.check_in
    #doc.notify_latecomer
  end

  def notify_latecomer
    if self.cause_at_last_changed? && self.confirmed_at_last == :true
      comer = Latecomer.find_or_initialize_by(user: self, day: self.pass_time_at_last.to_date)
      comer.status = self.status_at_last
      comer.overtime = self.overtime_at_last
      comer.pass_time = self.pass_time_at_last
      comer.access_ids = self.access_ids_at_last
      comer.cause = self.cause_at_last
      comer.confirmed = self.confirmed_at_last
      comer.user_org_ids = self.org_ids
      comer.user_facility_ids = self.facility_ids
      comer.save
    end
  end

  def check_in
    if self.dorm_id_changed? || self.bed_mark_changed?
      b = dorm.beds.detect { |bed| bed.mark == self.bed_mark}
      b.owner = self if b
    end
  end

  def notify_face
    as = {}
    self.house_access_ips.each do |ip|
      as[ip.gsub('.','-')] = -1
    end

    if self.dorm_id_changed? || self.avatar_changed?
      unless as.blank?
        unless self.changes['dorm_id'][0].blank?
          r = Room.find_by(id: self.changes['dorm_id'][0])
          Face.where(:status.in => [:add, :added], user: self, facility_ids: r && r.parent_id).update_all({status: :delete})
        end         
        Face.create(status: :add, access_ips: as, user: self, face_id: self.face_id, facility_ids: self.facility_ids)
      end
    end
    
    if self.activated == false
      Face.where(:status.in => [:add, :added], user: self).update_all(status: :delete)
    end
  end



end