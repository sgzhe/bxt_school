class Classroom < Org

  belongs_to :department, class_name: 'Department', foreign_key: :parent_id, inverse_of: :classrooms, required: false
end
