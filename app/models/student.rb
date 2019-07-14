class Student < User
  field :grade
  field :entranced_at, type: Date
  field :sno
  field :face_id, type: Integer, default: 0

  validates :sno, uniqueness: { message: "is already taken." }
  #validates :face_id, uniqueness: { message: "is already taken." }

  def self.status_stats(opts = {})
    status = {}
    self.collection.aggregate([
                                  {"$match" => opts.merge({"_type" => "Student"})},
                                  { "$group" => { "_id" => "$status_at_last", "count" => { "$sum" => 1 }}}
                              ]).each { |s| status[s["_id"]] = s["count"] }
    return status
  end

  set_callback(:initialize, :before) do |doc|
    if doc.new_record?
      m = Student.order(face_id: -1).first.face_id
      m = 50000 if m < 50000
      doc.face_id = m + 1
    end
  end


end
