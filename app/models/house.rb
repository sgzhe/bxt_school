class House < Facility

  embeds_many :floors
  has_many :rooms, class_name: 'Room', foreign_key: :parent_id, inverse_of: :house, validate: false, dependent: :restrict_with_exception

end
