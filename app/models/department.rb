class Department < Org

  belongs_to :college, class_name: 'College', foreign_key: :parent_id, inverse_of: :departments
  has_many :classrooms, class_name: 'Classroom', foreign_key: :parent_id, inverse_of: :department, validate: false, dependent: :restrict_with_exception
end
