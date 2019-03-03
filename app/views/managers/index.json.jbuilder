json.result @managers, partial: 'managers/manager', as: :manager
json.paginate_meta(paginate_meta(@managers))