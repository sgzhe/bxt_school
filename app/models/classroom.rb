class Classroom < Party

  belongs_to :grade, class_name: 'Grade', primary_key: :parent_id, inverse_of: :classrooms, required: false
end
