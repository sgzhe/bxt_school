class Room < Facility

  belongs_to :floor, class_name: 'Floor', foreign_key: :parent_id, inverse_of: :rooms, required: false

end
