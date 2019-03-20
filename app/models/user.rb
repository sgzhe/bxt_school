require 'bcrypt'
class User
  include ModelBase
  include ActiveModel::SecurePassword

  field :name
  field :gender_mark, default: :male
  field :id_card
  field :ic_card
  field :tel
  field :avatar
  field :login
  field :password_digest

  belongs_to :org, class_name: 'Org', foreign_key: :org_id, inverse_of: :users, required: false
  belongs_to :facility, class_name: 'Facility', foreign_key: :facility_id, inverse_of: :users, required: false
  has_and_belongs_to_many :roles, class_name: 'Role', inverse_of: nil
  has_and_belongs_to_many :groups, class_name: 'Group', inverse_of: nil
  has_and_belongs_to_many :orgs, class_name: 'Org', inverse_of: nil
  has_and_belongs_to_many :facilities, class_name: 'Facility', inverse_of: nil

  default_scope -> { order_by(id: -1) }

  def parent_org(parent_id)
    orgs.detect { |org| org.id.to_s == parent_id.to_s }
  end

  def parent_facility(parent_id)
    facilities.detect { |facility| facility.id.to_s == parent_id.to_s }
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
    doc.org_ids = doc.org.parent_ids + [org_id] if doc.org
    doc.facility_ids = doc.facility.parent_ids + [facility_id] if doc.facility
  end

end