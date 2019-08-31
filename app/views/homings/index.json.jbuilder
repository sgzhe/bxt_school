json.result @homings, partial: "homings/homing", as: :homing
json.paginate_meta(paginate_meta(@homings))
json.direct_stats(@direct_stats)