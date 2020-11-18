class Card
  include ModelBase
  field :status, type: String, default: :normal #:delete, add
  field :card_access_ips, type: Hash, default: {}
  field :ic_card, type: String, default: 0
  field :facility_ids, type: Array, default: []
  field :counts, type: Integer, default: 0
  field :user_name, type: String, default: ''
  belongs_to :user
  belongs_to :house

  validates :card_access_ips, presence: true

  set_callback(:initialize, :after) do |doc|
    if doc.user
      doc.status = :add if doc.status == 'normal'
      doc.house ||= doc.user.house
      doc.card_access_ips = doc.house.try(:card_access_ips) if doc.card_access_ips.blank?
      doc.ic_card ||= doc.user.try(:ic_card)
      doc.facility_ids = doc.user.facility_ids
      doc.user_name = doc.user.name
    end
  end

  set_callback(:save, :before) do |doc|
    doc.counts += 1
    if counts > 20
      doc.status = 'fail'
    end
    if doc.status == 'add'
      doc.status = 'added' if doc.card_access_ips.any? {|k, v| v == 1}
    end

    if doc.status == 'delete'
      doc.status = 'deleted' if doc.card_access_ips.any? {|k, v| v == -1}
    end
  end

end