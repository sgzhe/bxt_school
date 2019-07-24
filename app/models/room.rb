class Room < Facility

  field :dorm_type, type: Symbol, default: :men #men woman
  field :dorm_toward, type: Symbol, default: :east #south west north

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

  def self.bed_stats(opts = {})
    Room.collection.aggregate([
                                  {"$match": opts.merge({"_type": "Room"})},
                                  {"$project": {beds: 1, owners: {"$filter": {input: "$beds", as: "item", cond: {"$ifNull": ["$$item.owner_id", false]}}}}},
                                  {"$group" => {"_id" => "null", "total" => {"$sum" => {"$size" => "$beds"}}, "owners" => {"$sum" => {"$size" => "$owners"}}}}
                              ]).first
  end
end
