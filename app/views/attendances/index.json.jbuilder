json.result @attendances, partial: 'attendances/attendance', as: :attendance
json.paginate_meta(paginate_meta(@attendances))