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

  has_and_belongs_to_many :roles, class_name: 'Role', inverse_of: nil
  has_and_belongs_to_many :groups, class_name: 'Group', inverse_of: nil
  has_many :trackers

  default_scope -> { order_by(id: -1) }

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

end