json.result @students, partial: 'students/student', as: :student
json.paginate_meta(paginate_meta(@students))