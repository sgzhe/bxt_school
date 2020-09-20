class Package
  include ModelBase
  field :ver, type: String, default: ''
  mount_uploader :patch, AvatarUploader

  default_scope -> { order_by(ver: -1) }

end
