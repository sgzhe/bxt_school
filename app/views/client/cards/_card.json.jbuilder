json.extract! card, :id, :id_card, :card_access_ips, :status, :created_at, :updated_at
if card.user
  json.user_id(card.user.id)
  json.user_name(card.user.name)
end

