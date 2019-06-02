class Student < User
  field :grade
  field :entranced_at, type: Date

  def self.status_stats(opts = {})
    status = {}
    self.collection.aggregate([
                                  {"$match" => opts.merge({"_type" => "Student"})},
                                  { "$group" => { "_id" => "$status_at_last", "count" => { "$sum" => 1 }}}
                              ]).each { |s| status[s["_id"]] = s["count"] }
    return status
  end


end
