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

  def find(id)
    @houses.find { |house| house.id.to_s == id.to_s }
  end
end