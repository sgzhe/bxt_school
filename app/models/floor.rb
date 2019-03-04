class Floor < Facility

  belongs_to :house, class_name: 'House', foreign_key: :parent_id, inverse_of: :floors
  has_many :rooms, class_name: 'Room', foreign_key: :parent_id, inverse_of: :floor, validate: false, dependent: :restrict_with_exception

end
