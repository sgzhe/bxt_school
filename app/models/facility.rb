class Facility
  include ModelBase
  include Mongoid::Tree

  field :title

  default_scope -> { order_by(id: -1) }

  belongs_to :charge_person, foreign_key: :user_id, class_name: 'User', required: false
  has_many :users, class_name: 'User', foreign_key: :facility_id, inverse_of: :facility, validate: false, dependent: :restrict_with_exception

end
