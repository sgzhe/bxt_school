class Bed < Facility

  belongs_to :room, class_name: 'Room', foreign_key: :parent_id, inverse_of: :beds, required: false

  set_callback(:save, :after) do |doc|
    doc.room.update(total_beds: doc.room.beds.count,
                    vacant_beds: doc.room.beds.where(owner_id: nil).count)
  end

end
