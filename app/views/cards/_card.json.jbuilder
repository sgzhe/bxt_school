json.extract! card, :id, :ic_card, :card_access_ips, :status, :counts, :user_id, :house_id, :created_at, :updated_at
if card.user
  json.user_name(card.user.name)
end

