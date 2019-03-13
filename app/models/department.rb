class Department < Org

  embeds_many :grades
  belongs_to :college, class_name: 'College', foreign_key: :parent_id, inverse_of: :departments
  has_many :classrooms, class_name: 'Classroom', foreign_key: :parent_id, inverse_of: :department, validate: false, dependent: :restrict_with_exception
  has_many :teachers, class_name: 'Teacher', foreign_key: :org_id, inverse_of: :department, validate: false, dependent: :restrict_with_exception
end
