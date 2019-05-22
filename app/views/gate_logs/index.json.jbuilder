json.array! @gate_logs, partial: 'gate_logs/gate_log', as: :gate_log
json.paginate_meta(paginate_meta(@gate_logs))