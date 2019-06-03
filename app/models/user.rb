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

  #default_scope -> { order_by(id: -1) }
  #scope :reside, ->(reside) { where(:pass_time_at_last.lte => reside.days.ago) }

  #validates :sno, uniqueness: { message: "is already taken." }
  def house_access_ips
    h = dorm && dorm.parent && dorm.parent.parent
    return Access.ips(h.id) if h
    []
  end

  def reside
    return 0 if pass_time_at_last.nil?
    (DateTime.now - pass_time_at_last).to_i
  end

  def aros
    aro_set = roles
    groups.each do |g|
      aro_set += g
      aro_set += g.roles
    end
    aro_set
  end

  has_secure_password

  set_callback(:initialize, :before) do |doc|
    doc.password = 'bxt-123' if :new_record?
  end

  set_callback(:save, :before) do |doc|
    if doc.dorm_id_changed?
      doc.facility_ids = doc.dorm.parent_ids + [doc.dorm_id]
    end
    if doc.dept_id_changed?
      doc.org_ids += doc.dept.parent_ids + [doc.dept_id]
    end
    if doc.access_ips_changed? || doc.avatar_changed?
      f = doc.access_ips.detect { |k, v| v != 1 }
      if f || doc.access_ips.empty?
        doc.access_status = false
      else
        doc.access_status = true
      end
    end
  end

end