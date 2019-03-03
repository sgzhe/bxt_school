class Student < User

  belongs_to :classroom, class_name: 'Classroom', foreign_key: :org_id, inverse_of: :students, required: false
  belongs_to :bed, class_name: 'Bed', foreign_key: :facility_id, inverse_of: :students, required: false

end
