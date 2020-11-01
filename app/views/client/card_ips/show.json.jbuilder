if @client_card_ip
  json.partial! "client/card_ips/client_card_ip", client_card_ip: @client_card_ip
end
if @client_card_ips
  json.array! @client_card_ips, partial: "client/card_ips/client_card_ip", as: :client_card_ip
end

