class Room < Facility

  field :floor

  belongs_to :house, class_name: 'House', foreign_key: :parent_id, inverse_of: :rooms, required: false
  has_many :beds, class_name: 'Bed', foreign_key: :parent_id, inverse_of: :room, validate: false, dependent: :restrict_with_exception

end
