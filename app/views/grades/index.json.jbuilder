json.result @grades, partial: 'grades/grade', as: :grade
json.paginate_meta(paginate_meta(@grades))
