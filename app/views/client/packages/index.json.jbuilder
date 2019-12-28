json.result @packages, partial: "client/packages/package", as: :package
json.paginate_meta(paginate_meta(@packages))