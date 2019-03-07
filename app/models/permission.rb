class Permission
  include ModelBase

  belongs_to :aro, class_name: 'Aro'
  belongs_to :aco, polymorphic: true

end
