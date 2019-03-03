class Facility
  include ModelBase

  field :title

  default_scope -> { order_by(id: -1) }

  has_many :user, class_name: 'User', foreign_key: :facility_id, inverse_of: :facility, validate: false, dependent: :restrict_with_exception
end
