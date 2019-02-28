json.result @beds, partial: 'beds/bed', as: :bed
json.paginate_meta(paginate_meta(@beds))