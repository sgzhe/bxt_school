json.result @users, partial: 'incomings/incoming', as: :user
json.paginate_meta(paginate_meta(@users))
json.status_stats(@status_stats)