class HouseMgr
  include ::Singleton
  attr_reader :houses

  def initialize
    load
  end

  def load
    @houses = House.all.to_a
    @updated_at = Time.now
    Rails.cache.write('houses_by_updated_at', @updated_at)
  end

  alias reload load

  def cache
    if Rails.cache.read('houses_by_updated_at') != @updated_at
      reload
    end
  end

  def find(ids)
    @houses.find { |house| Array(ids).map(&:to_s).include?(house.id.to_s) }
  end

  def self.find(ids)
    instance.find(ids)
  end
end