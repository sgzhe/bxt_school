json.result @trackers, partial: 'trackers/tracker', as: :tracker
json.paginate_meta(paginate_meta(@trackers))