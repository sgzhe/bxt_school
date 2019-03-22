json.result @accesses, partial: 'accesses/access', as: :access
json.paginate_meta(paginate_meta(@accesses))