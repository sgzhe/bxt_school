class Classroom < Org

  belongs_to :department, class_name: 'Department', foreign_key: :parent_id, inverse_of: :classrooms, required: false
  has_many :students, class_name: 'Student', foreign_key: :org_id, inverse_of: :classroom, validate: false, dependent: :restrict_with_exception

  def grade
    department.grades.detect { |grade| grade.mark == grade_mark }
  end
end
