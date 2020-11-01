json.result @card_ips, partial: "card_ips/card_ip", as: :card_ip
json.paginate_meta(paginate_meta(@card_ips))
