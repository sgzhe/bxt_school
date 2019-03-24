class Room < Facility

  field :floor_mark

  belongs_to :house, class_name: 'House', foreign_key: :parent_id, inverse_of: :rooms, required: false
  embeds_many :beds, class_name: 'Bed', cascade_callbacks: true do
    def empties
      where(owner_id: nil)
    end
  end

  def floor
    house.floors.detect { |floor| floor.mark == floor_mark }
  end

  def check_in(user, bed = nil)
    bed ||= beds.empties.first
    bed.owner = user
    user.room = self
    user.bed_no = bed.bed_no
    save && user.save
  end

  def total_beds
    beds.count
  end

  def vacant_beds
    beds.empties.count
  end
end
