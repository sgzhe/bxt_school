class Department < Org

  belongs_to :college, class_name: 'College', primary_key: :parent_id, inverse_of: :departments, required: false
  has_many :grades, class_name: 'Grade', foreign_key: :parent_id, inverse_of: :department, validate: false, dependent: :restrict_with_exception

end
