json.result @latecomers, partial: 'client/latecomers/latecomer', as: :latecomer
json.paginate_meta(paginate_meta(@latecomers))