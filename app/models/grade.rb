class Grade < Org

  belongs_to :department, class_name: 'Department', foreign_key: :parent_id, inverse_of: :grades, required: false
  has_many :classrooms, class_name: 'Classroom', foreign_key: :parent_id, inverse_of: :grade, validate: false, dependent: :restrict_with_exception

end
