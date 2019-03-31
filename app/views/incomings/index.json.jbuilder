json.result @users, partial: 'incomings/incoming', as: :user
json.paginate_meta(paginate_meta(@users))