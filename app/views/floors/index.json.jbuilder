json.result @floors, partial: 'floors/floor', as: :floor
json.paginate_meta(paginate_meta(@floors))