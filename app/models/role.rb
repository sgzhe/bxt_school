class Role < Aro

  has_and_belongs_to_many :groups, class_name: 'Group', inverse_of: :roles

end
