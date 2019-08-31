class HolidayMgr
  include ::Singleton
  attr_reader :holidays

  def initialize
    load
  end

  def load
    @holidays = {}
    Holiday.all.each do |h|
      (h.end_at - h.start_at).to_i.times do |i|
        @holidays[(h.start_at + i.days).strftime("%Y%m%d")] = h.title
      end
    end
  end

  alias reload load

  def check(day)
    @holidays[day.strftime("%Y%m%d")]
  end

end