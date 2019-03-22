json.result @gates, partial: 'gates/gate', as: :gate
json.paginate_meta(paginate_meta(@gates))