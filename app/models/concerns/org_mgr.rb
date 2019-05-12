class OrgMgr
  include ::Singleton

  def initialize
    load
  end

  def load
    Rails.cache.write('bxt_orgs', Org.traverse {|o| o})
  end

  alias reload load

  def orgs
    Rails.cache.fetch('bxt_orgs') do
      Org.traverse {|o| o}
    end
  end

  def find(id)
    orgs.find { |org| org.id.to_s == id.to_s }
  end

  def find_by_parent(parent_id)
    orgs.select { |org| org.parent_id.to_s == parent_id.to_s }
  end

  def traverse(parent_id = nil, depth = 99, &block)
    find_by_parent(parent_id).select do |org|
      [yield(org)] + send(:traverse, org.id, depth, &block) if depth > org.depth
    end
  end

end
