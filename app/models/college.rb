class College < Org

  has_many :departments, class_name: 'Department', foreign_key: :parent_id, inverse_of: :college, validate: false, dependent: :restrict_with_exception

end
