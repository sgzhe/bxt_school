class Student < User

  belongs_to :classroom, class_name: 'Classroom', foreign_key: :org_id, inverse_of: :students, required: false
  belongs_to :room, class_name: 'Room', foreign_key: :facility_id, inverse_of: :students, required: false

end
