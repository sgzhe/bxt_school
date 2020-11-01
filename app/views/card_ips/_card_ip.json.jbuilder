json.extract! card_ip, :id, :access_no, :access_ip, :user_id, :house_id, :operation, :status, :errno, :created_at, :updated_at
if card_ip.user
  json.user_name(card_ip.user.name)
end