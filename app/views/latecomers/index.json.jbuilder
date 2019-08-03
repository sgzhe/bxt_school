json.result @latecomers, partial: 'latecomers/latecomer', as: :latecomer
json.paginate_meta(paginate_meta(@latecomers))