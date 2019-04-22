class Room < Facility

  field :dorm_type
  field :total_beds, type: Integer, default: 8

  belongs_to :floor, class_name: 'Floor', foreign_key: :parent_id, inverse_of: :rooms, required: false
  embeds_many :beds, class_name: 'Bed', cascade_callbacks: true do
    def empties
      where(owner_id: nil)
    end
  end

  def check_in(user, bed = nil)
    bed ||= beds.empties.first
    if bed
      bed.owner = user
      user.dorm = self
      user.bed_mark = bed.mark
    end
    save && user.save
  end

  def vacant_beds
    beds.empties.count
  end
end
