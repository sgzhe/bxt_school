class Room < Facility

  field :dorm_type, type: Symbol, default: :men #men woman
  field :dorm_toward, type: Symbol, default: :east #south west north
  field :rating_num, type: Integer, default: 0
  field :true_num, type: Integer, default: 0

  belongs_to :floor, class_name: 'Floor', foreign_key: :parent_id, inverse_of: :rooms, required: false
  embeds_many :beds, class_name: 'Bed', cascade_callbacks: true do
    def empties
      where(owner_id: nil)
    end
  end

  def house_access_ips
    as = {}
    ips = Access.where(:parent_id.in => self.parent_ids).map(&:ip).delete_if { |k| k.blank? }
    ips.each do |ip|
      as[ip.tr('.', '-')] = 0
    end
    as
  end

  def check_in(user, bed_mark = nil)
    bed = beds.detect { |bed| bed.mark == bed_mark }
    bed ||= beds.empties.first
    if bed
      bed.owner = user
      save
    end
  end

  def check_out(opts = { user_id: nil, bed_mark: nil })
    bed = beds.detect { |bed| bed.owner_id == opts[:user_id] || bed.mark == opts[:bed_mark] }
    if bed && bed.owner_id
      bed.owner_id = nil
      bed.owner_name = nil
      save
    end
  end

  def vacant_beds
    beds.empties.count
  end

  def total_beds
    beds.count
  end

  def self.bed_stats(opts = {})
    Room.collection.aggregate([
                                  {"$match": opts.merge({"_type": "Room", beds: { "$exists": true }})},
                                  {"$project": {beds: 1, owners: {"$filter": {input: "$beds", as: "item", cond: {"$and":[{"$ifNull": ["$$item", false]},{"$ifNull": ["$$item.owner_id", false]}]}}}}},
                                  {"$group" => {"_id" => "null", "total" => {"$sum" => {"$size" => "$beds"}}, "owners" => {"$sum" => {"$size" => "$owners"}}}}
                              ]).first
  end
end
