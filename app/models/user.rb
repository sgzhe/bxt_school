require 'bcrypt'
class User
  include ModelBase
  include ActiveModel::SecurePassword

  field :name
  field :gender_mark, default: :male
  field :id_card
  field :ic_card
  field :ic_card2
  field :tel
  field :login
  field :password_digest
  field :bed_mark
  field :sno
  field :img
  field :img2
  field :face_id
  field :access_ips, type: Hash, default: {}
  field :access_status, type: Boolean, default: true

  field :pass_time_at_last, type: DateTime, default: -> { DateTime.now.at_beginning_of_day}
  field :status_at_last, default: :back
  field :direction_at_last, default: :in
  field :overtime_at_last, type: Integer, default: 0
  field :access_ids_at_last, type: Array, default: []

  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []

  mount_base64_uploader :avatar, AvatarUploader

  belongs_to :access_at_last, class_name: 'Access', foreign_key: :access_id, required: false
  belongs_to :dorm, class_name: 'Room', required: false
  belongs_to :dept, class_name: 'Org', required: false
  has_and_belongs_to_many :roles, class_name: 'Role', inverse_of: nil
  has_and_belongs_to_many :groups, class_name: 'Group', inverse_of: nil
  has_many :trackers

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
    (DateTime.now - pass_time_at_last).to_i
  end

  def role?(role_mark)
    roles.any? { |role| role.mark.to_s == role_mark.to_s }
  end

  def allow?(aco_id, operation)
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
    doc.password = 'bxt-123' if :new_record? && doc.password.blank?
  end

  set_callback(:save, :before) do |doc|
    if doc.dorm_id_changed?
      doc.facility_ids = doc.dorm.parent_ids + [doc.dorm_id]
      as = {}
      doc.house_access_ips.each do |ip|
        as[ip.gsub('.','-')] = -1
      end
      unless as.blank?
        Face.create(status: :add, access_ips: as, user: doc, face_id: doc.face_id, facility_ids: doc.facility_ids)
        Face.where(status: :added, user: doc, facility_ids: previous_changes['facility_ids']).update_all(status: :delete)
      end
      #doc.access_status = false
    end
    if doc.dept_id_changed?
      doc.org_ids += doc.dept.parent_ids + [doc.dept_id]
    end
    if doc.avatar_changed?
      #doc.access_status = false
      as = {}
      doc.house_access_ips.each do |ip|
        as[ip.gsub('.','-')] = -1
      end
      unless as.blank?
        Face.create(status: :add, access_ips: as, user: doc, face_id: doc.face_id, facility_ids: doc.facility_ids)
      end

    end
    # if doc.access_ips_changed?
    #   ips = doc.house_access_ips
    #
    #   doc.access_ips.delete_if { |k, v| v == -1 }
    #   doc.access_status = ips.none? { |ip| p doc.access_ips[ip] != 1 }
    # end
  end

  set_callback(:destroy, :before) do |doc|
    Face.where(status: :add, user: doc, facility_ids: previous_changes['facility_ids']).update_all(status: :delete)
  end

end