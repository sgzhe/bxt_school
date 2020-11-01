if @card_ip
  json.partial! "card_ips/card_ip", card_ip: @card_ip
end
if @card_ips
  json.array! @card_ip, partial: "card_ips/card_ip", as: :card_ip
end