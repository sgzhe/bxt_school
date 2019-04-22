class Floor < Facility

  belongs_to :house, class_name: 'House', foreign_key: :parent_id, inverse_of: :floors, required: false
end