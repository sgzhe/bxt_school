json.result @webcams, partial: 'webcams/webcam', as: :webcam
json.paginate_meta(paginate_meta(@webcams))