json.result @permissions, partial: 'permissions/permission', as: :permission
json.paginate_meta(paginate_meta(@permissions))