json.result @groups, partial: 'groups/group', as: :group
json.paginate_meta(paginate_meta(@groups))