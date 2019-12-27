class Package
  include ModelBase
  field :ver, type: String
  mount_uploader :patch, AvatarUploader

  default_scope -> { order_by(id: -1) }

end
