json.result @houses, partial: 'houses/house', as: :house
json.paginate_meta(paginate_meta(@houses))