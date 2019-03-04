class Tracker
  include ModelBase

  field :month, type: Date, default: -> { Date.today.at_beginning_of_month }
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []

  belongs_to :user
  embeds_many :traces
  embeds_many :attendances

  validates :user_id, uniqueness: { scope: :month, message: "should happen once per month" }

  def self.pass(user_id, gateway_id, direction)
    d = Date.today
    t = Tracker.find_or_initialize_by(user_id: user_id, month: d.at_beginning_of_month)
    t.traces.build(pass_time: d, gateway_id: gateway_id, direction: direction)
    t.save
  end

end
