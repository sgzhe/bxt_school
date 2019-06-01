class Room < Facility

  field :dorm_type

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

  def total_beds
    beds.count
  end



  def self.stats
    Room.collection.aggregate([
                                  {"$match": {"_type": "Room"}},
                                  {"$project": {beds: 1, owners: {"$filter": {input: "$beds", as: "item", cond: {"$ifNull": ["$$item.owner_id", false]}}}}},
                                  {"$group" => {"_id" => "null", "count" => {"$sum" => {"$size" => "$beds"}}, "owners" => {"$sum" => {"$size" => "$owners"}}}}
                              ]).to_a
  end
end
