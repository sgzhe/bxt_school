json.result @client_card_ips, partial: "client/card_ips/client_card_ip", as: :client_card_ip
json.paginate_meta(paginate_meta(@client_card_ips))