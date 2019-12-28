json.result @houses, partial: 'client/houses/house', as: :house
json.paginate_meta(paginate_meta(@houses))