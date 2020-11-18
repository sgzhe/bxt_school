json.extract! card, :id, :ic_card, :card_access_ips, :status, :counts, :user_id, :house_id, :created_at, :updated_at
json.user_name(card.user_name.present? ? card.user_name : card.user.try(:name) || '')

