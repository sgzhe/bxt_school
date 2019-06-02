class Access < Facility

  field :closing_at, type: Integer, default: 1350
  field :opening_at, type: Integer, default: 240
  field :ip
  field :direction, type: Symbol, default: :in #:in :out
  field :status

  def self.ips(facility_id)
    ips = []
    Access.where(parent_ids: facility_id ).each do |a|
      ips << a.ip unless a.ip.blank?
    end
    ips
  end

end
