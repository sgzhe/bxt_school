class Face
  include ModelBase
  field :status, type: Symbol, default: :normal #:delete, add
  field :access_ips, type: Hash, default: {}
  field :face_id, type: Integer, default: 0
  field :facility_ids, type: Array, default: []
  belongs_to :user, required: false

  set_callback(:save, :before) do |doc|
    if doc.access_ips_changed?
      if doc.status == :add
        doc.status = :added if doc.access_ips.any? { |k, v| v == 1 }
      end

      if doc.status == :delete
        doc.status = :deleted if doc.access_ips.any? { |k, v| v == -1 }
      end
    end
  end
end