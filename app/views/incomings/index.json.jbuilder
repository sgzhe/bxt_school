json.result @users, partial: 'incomings/incoming', as: :user
json.paginate_meta(paginate_meta(@users))
json.status_statistics(@group_by_status)