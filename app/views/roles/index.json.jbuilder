json.result @roles, partial: 'roles/role', as: :role
json.paginate_meta(paginate_meta(@roles))