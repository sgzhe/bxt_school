json.result @holidays, partial: "holidays/holiday", as: :holiday
json.paginate_meta(paginate_meta(@holidays))