class Access < Facility

  field :closing_at, type: Integer, default: 1410
  field :opening_at, type: Integer, default: 240
  field :ip
  field :direction, type: Symbol, default: :in #:in :out
  field :status

  def self.ips(facility_id)
    Access.where(parent_ids: facility_id).map(&:ip).delete_if { |k, v| v.blank?}
  end

end
