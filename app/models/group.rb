class Group < Aro

  has_and_belongs_to_many :roles, class_name: 'Role', inverse_of: :group

end
