class Student < User
  field :grade
  field :entranced_at, type: Date

  def self.group_by_status(opts = {})
    status = {}
    self.collection.aggregate([
                                  {"$match" => opts.merge({"_type" => "Student"})},
                                  { "$group" => { "_id" => "$status_at_last", "count" => { "$sum" => 1 }}}
                              ]).each { |s| status[s["_id"]] = s["count"] }
    return status
  end


end
