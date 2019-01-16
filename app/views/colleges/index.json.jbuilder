json.result @colleges, partial: 'colleges/college', as: :college
json.paginate_meta(paginate_meta(@colleges))