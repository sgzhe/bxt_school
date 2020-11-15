json.extract! card, :id, :ic_card, :card_access_ips, :user_id, :house_id, :status, :counts, :created_at, :updated_at
if card.user
  json.user_name(card.user.name)
end

