class HouseMgr
  include ::Singleton
  attr_reader :houses

  def initialize
    load
  end

  def load
    @houses = House.all.to_a
  end

  alias reload load

  def find(ids)
    @houses.find { |house| Array(ids.map(&:to_s)).include?(house.id.to_s) }
  end
end