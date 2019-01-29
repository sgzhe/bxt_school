class Classroom < Org

  belongs_to :grade, class_name: 'Grade', foreign_key: :parent_id, inverse_of: :classrooms, required: false
end
