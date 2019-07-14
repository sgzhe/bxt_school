class Face
  include ModelBase
  field :status, type: Symbol, default: :normal #:delete, add
  field :access_ips, type: Hash, default: {}
  field :face_id, type: Integer, default: 0
  field :facility_ids, type: Array, default: []

  belongs_to :user, required: false

  # set_callback(:initialize, :before) do |doc|
  #   self.user = Student.where(face_id: self.face_id).first
  # end

  set_callback(:save, :before) do |doc|
    if doc.access_ips_changed?
      if doc.status == :add
        doc.status = :added if doc.access_ips.none? { |k, v| v == -1 }
      end

      if doc.status == :delete
        doc.status = :deleted if doc.access_ips.none? { |k, v| v == 1 }
      end
    end
  end
end