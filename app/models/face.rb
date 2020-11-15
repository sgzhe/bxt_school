class Face
  include ModelBase
  field :status, type: String, default: :normal #:delete, add, fail
  field :access_ips, type: Hash, default: {}
  field :face_id, type: Integer, default: 0
  field :facility_ids, type: Array, default: []
  field :access_mark, type: String, default: ''
  field :counts, type: Integer, default: 0
  belongs_to :user
  belongs_to :house

  validates :access_ips, presence: true

  set_callback(:initialize, :after) do |doc|
    if self.user
      self.status = :add if self.status == 'normal'
      self.house ||= self.user.house
      self.access_ips = self.house.try(:access_ips) if self.access_ips.blank?
      self.face_id = self.user.try(:face_id)
      self.facility_ids = self.user.facility_ids
    end
  end

  set_callback(:save, :before) do |doc|
    doc.counts += 1
    if counts > 20
      doc.status = 'fail'
    end
    if doc.status == 'add'
      doc.status = 'added' if doc.access_ips.all? {|k, v| v == 1}
    end

    if doc.status == 'delete'
      doc.status = 'deleted' if doc.access_ips.all? {|k, v| v == -1}
    end
  end
end