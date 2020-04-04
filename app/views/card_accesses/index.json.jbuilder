json.result @card_accesses, partial: "card_accesses/card_access", as: :card_access
json.paginate_meta(paginate_meta(@card_accesses))