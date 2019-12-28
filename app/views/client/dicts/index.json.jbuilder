json.result @dicts, partial: 'client/dicts/dict', as: :dict
json.paginate_meta(paginate_meta(@dicts))