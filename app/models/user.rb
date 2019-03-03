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

  has_secure_password




end