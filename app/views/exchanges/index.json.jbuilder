json.result @exchanges, partial: "exchanges/exchange", as: :exchange
json.paginate_meta(paginate_meta(@exchanges))