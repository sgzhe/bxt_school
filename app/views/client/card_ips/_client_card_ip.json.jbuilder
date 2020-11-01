json.extract! client_card_ip, :id, :access_no, :access_ip, :user_id, :house_id, :operation, :status, :errno, :created_at, :updated_at
if client_card_ip.user
  json.user_name(client_card_ip.user.name)
end