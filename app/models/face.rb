class Face
  include ModelBase
  field :status, type: Symbol, default: :normal #:delete, add
  field :access_ips, type: Hash, default: {}
  field :face_id, type: Integer, default: 0
  field :facility_ids, type: Array, default: []
  field :face_url
  field :user_id
  field :user_name

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
    if doc.user
      doc.face_url = doc.user.avatar.url
      doc.user_name = doc.user.name
      doc.user_id = doc.user.id
    end
  end
end