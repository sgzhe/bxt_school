json.result @teachers, partial: 'teachers/teacher', as: :teacher
json.paginate_meta(paginate_meta(@teachers))