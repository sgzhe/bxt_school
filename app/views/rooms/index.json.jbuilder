json.result @rooms, partial: 'rooms/room', as: :room
json.paginate_meta(paginate_meta(@rooms))