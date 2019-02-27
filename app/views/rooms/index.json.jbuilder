json.result @rooms, partial: 'rooms/room', as: :rooms
json.paginate_meta(paginate_meta(@rooms))