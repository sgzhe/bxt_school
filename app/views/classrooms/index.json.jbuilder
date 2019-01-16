json.result @classrooms, partial: 'classrooms/classroom', as: :classroom
json.paginate_meta(paginate_meta(@classrooms))