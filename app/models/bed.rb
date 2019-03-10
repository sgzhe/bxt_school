class Bed < Facility

  belongs_to :room, class_name: 'Room', foreign_key: :parent_id, inverse_of: :beds, required: false

end
