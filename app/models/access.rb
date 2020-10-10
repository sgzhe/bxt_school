class Access < Facility

  field :closing_at, type: Integer, default: 1410
  field :opening_at, type: Integer, default: 240
  field :ip, type: String
  field :direction, type: String, default: :in #:in :out
  field :status, type: String
  field :mark, type: String

  belongs_to :house, class_name: 'House', foreign_key: :parent_id, inverse_of: :accesses, required: false

  def self.ips(facility_id)
    self.where(parent_ids: facility_id).map(&:ip).delete_if { |k, v| v.blank?}
  end
end