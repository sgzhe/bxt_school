class Card
  include ModelBase
  field :status, type: Symbol, default: :normal #:delete, add
  field :card_access_ips, type: Hash, default: {}
  field :id_card, type: String, default: 0
  field :facility_ids, type: Array, default: []
  belongs_to :user, required: false
  belongs_to :house, required: false

  set_callback(:initialize, :after) do |doc|
    if doc.user
      doc.status = :add if doc.status == :normal
      doc.card_access_ips ||= doc.user.house.card_access_ips
      doc.id_card = doc.user.id_card
      doc.facility_ids = doc.user.facility_ids
    end
  end

  set_callback(:save, :before) do |doc|
    if doc.card_access_ips_changed?
      if doc.status == :add
        doc.status = :added if doc.card_access_ips.any? { |k, v| v == 1 }
      end

      if doc.status == :delete
        doc.status = :deleted if doc.card_access_ips.any? { |k, v| v == -1 }
      end
    end
  end

end