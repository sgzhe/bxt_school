json.result @video_recorders, partial: 'video_recorders/video_recorder', as: :video_recorder
json.paginate_meta(paginate_meta(@video_recorders))