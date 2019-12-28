json.result @trackers, partial: 'client/trackers/tracker', as: :tracker
json.paginate_meta(paginate_meta(@trackers))