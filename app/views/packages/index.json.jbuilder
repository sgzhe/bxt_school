json.result @packages, partial: "packages/package", as: :package
json.paginate_meta(paginate_meta(@packages))