class Tracker
  include ModelBase

  field :month, type: Date, default: -> { Date.today.at_beginning_of_month }
  field :org_ids, type: Array, default: []
  field :facility_ids, type: Array, default: []

  belongs_to :user
  embeds_many :traces
  embeds_many :attendances

  validates :user_id, uniqueness: { scope: :month, message: "should happen once per month" }

end
