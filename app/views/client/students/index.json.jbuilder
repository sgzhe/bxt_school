json.result @students, partial: 'client/students/student', as: :student
json.paginate_meta(paginate_meta(@students))