class Room < Facility

  belongs_to :floor, class_name: 'Floor', foreign_key: :parent_id, inverse_of: :rooms, required: false
  has_many :beds, class_name: 'Bed', foreign_key: :parent_id, inverse_of: :room, validate: false, dependent: :restrict_with_exception

end
