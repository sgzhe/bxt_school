json.result @floors, partial: 'floors/floor', as: :floors
json.paginate_meta(paginate_meta(@floors))