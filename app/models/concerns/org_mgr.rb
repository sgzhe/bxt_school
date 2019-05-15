class OrgMgr
  include ::Singleton

  def initialize
    load
  end

  def load
    @orgs = Org.all.to_a
  end

  alias reload load

  def orgs
    @orgs
  end

  def find(id)
    orgs.find { |org| org.id.to_s == id.to_s }
  end

  def find_by_parent(parent_id)
    orgs.select { |org| org.parent_id.to_s == parent_id.to_s }
  end

  def traverse(parent_id = nil)
    result = []
    find_by_parent(parent_id).each do |org|
      result << org
      result << find_by_parent(org.id)
    end
    result.flatten
  end

end
