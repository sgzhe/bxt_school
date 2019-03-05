require 'bcrypt'
class User
  include ModelBase
  include ActiveModel::SecurePassword

  field :name
  field :gender
  field :id_card
  field :ic_card
  field :tel
  field :avatar
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []

  field :login
  field :password_digest

  belongs_to :org, class_name: 'Org', foreign_key: :org_id, inverse_of: :users, required: false
  belongs_to :facility, class_name: 'Facility', foreign_key: :facility_id, inverse_of: :users, required: false
  has_and_belongs_to_many :privilege_sets, class_name: 'PrivilegeSet', inverse_of: nil
  has_and_belongs_to_many :roles, class_name: 'Role', inverse_of: nil
  has_and_belongs_to_many :groups, class_name: 'Group', inverse_of: nil

  has_secure_password

end