json.result @departments, partial: 'departments/department', as: :department
json.paginate_meta(paginate_meta(@departments))
