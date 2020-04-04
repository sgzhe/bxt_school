json.result @cards, partial: "cards/card", as: :card
json.paginate_meta(paginate_meta(@cards))