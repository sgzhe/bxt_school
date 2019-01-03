require 'bcrypt'
class User
  include ModelBase
  include ActiveModel::SecurePassword

  field :gender
  field :id_card
  field :ic_card
  field :tel
  field :avatar

  field :name
  field :password_digest

  has_secure_password


end